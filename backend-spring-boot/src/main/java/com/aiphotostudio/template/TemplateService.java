package com.aiphotostudio.template;

import com.aiphotostudio.common.ApiException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class TemplateService {

    private final TemplateRepository templateRepository;
    private final CategoryRepository categoryRepository;

    public TemplateService(
            TemplateRepository templateRepository,
            CategoryRepository categoryRepository
    ) {
        this.templateRepository = templateRepository;
        this.categoryRepository = categoryRepository;
    }

    public List<CategoryResponse> listCategories() {
        return categoryRepository.findAllByOrderByNameAsc().stream()
                .map(CategoryResponse::from)
                .toList();
    }

    public List<TemplateResponse> listTemplates(String category, Boolean trending) {
        List<TemplateEntity> templates;

        if (Boolean.TRUE.equals(trending)) {
            templates = templateRepository.findByActiveTrueAndTrendingTrueOrderByNameAsc();
        } else if (StringUtils.hasText(category) && !"all".equalsIgnoreCase(category)) {
            templates = templateRepository
                    .findByActiveTrueAndCategoryIgnoreCaseOrderByNameAsc(category.trim());
        } else {
            templates = templateRepository.findByActiveTrueOrderByNameAsc();
        }

        return templates.stream().map(TemplateResponse::from).toList();
    }

    public TemplateResponse getTemplate(String idOrSlug) {
        TemplateEntity entity = findActiveTemplate(idOrSlug);
        return TemplateResponse.from(entity);
    }

    private TemplateEntity findActiveTemplate(String idOrSlug) {
        if (!StringUtils.hasText(idOrSlug)) {
            throw notFound();
        }

        String key = idOrSlug.trim();
        try {
            UUID id = UUID.fromString(key);
            return templateRepository.findByIdAndActiveTrue(id)
                    .orElseThrow(this::notFound);
        } catch (IllegalArgumentException ignored) {
            return templateRepository.findBySlugAndActiveTrue(key.toLowerCase(Locale.ROOT))
                    .orElseThrow(this::notFound);
        }
    }

    private ApiException notFound() {
        return new ApiException(
                "TEMPLATE_NOT_FOUND",
                "Style not found.",
                HttpStatus.NOT_FOUND
        );
    }
}
