package com.aiphotostudio.template;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TemplateRepository extends JpaRepository<TemplateEntity, UUID> {

    List<TemplateEntity> findByActiveTrueOrderByNameAsc();

    List<TemplateEntity> findByActiveTrueAndCategoryIgnoreCaseOrderByNameAsc(String category);

    List<TemplateEntity> findByActiveTrueAndTrendingTrueOrderByNameAsc();

    Optional<TemplateEntity> findBySlugAndActiveTrue(String slug);

    Optional<TemplateEntity> findByIdAndActiveTrue(UUID id);
}
