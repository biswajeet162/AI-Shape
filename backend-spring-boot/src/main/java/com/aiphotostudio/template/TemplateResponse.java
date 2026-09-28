package com.aiphotostudio.template;

import java.time.Instant;
import java.util.UUID;

public record TemplateResponse(
        UUID id,
        String name,
        String slug,
        String category,
        String description,
        String thumbnailUrl,
        boolean trending,
        Instant createdAt
) {
    public static TemplateResponse from(TemplateEntity entity) {
        return new TemplateResponse(
                entity.getId(),
                entity.getName(),
                entity.getSlug(),
                entity.getCategory(),
                entity.getDescription(),
                entity.getThumbnailUrl(),
                entity.isTrending(),
                entity.getCreatedAt()
        );
    }
}
