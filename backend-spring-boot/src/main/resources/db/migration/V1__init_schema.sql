-- Phase 1: minimal schema foundation for templates & generations.
-- Full seeding arrives in Phase 2.

CREATE TABLE IF NOT EXISTS categories (
    id          UUID PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS templates (
    id              UUID PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    slug            VARCHAR(150) NOT NULL UNIQUE,
    category        VARCHAR(100) NOT NULL,
    description     TEXT NOT NULL,
    thumbnail_url   TEXT NOT NULL,
    prompt          TEXT NOT NULL,
    active          BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_templates_category ON templates (category);
CREATE INDEX IF NOT EXISTS idx_templates_active ON templates (active);

CREATE TABLE IF NOT EXISTS generations (
    id                   UUID PRIMARY KEY,
    template_id          UUID NOT NULL REFERENCES templates (id),
    status               VARCHAR(32) NOT NULL,
    original_image_url   TEXT,
    result_image_url     TEXT,
    error_message        TEXT,
    created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at         TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_generations_status ON generations (status);
CREATE INDEX IF NOT EXISTS idx_generations_created_at ON generations (created_at DESC);
