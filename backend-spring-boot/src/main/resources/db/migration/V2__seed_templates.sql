-- Phase 2: trending flag + seed categories and templates.

ALTER TABLE templates
    ADD COLUMN IF NOT EXISTS trending BOOLEAN NOT NULL DEFAULT FALSE;

CREATE INDEX IF NOT EXISTS idx_templates_trending ON templates (trending);

INSERT INTO categories (id, name, slug, created_at) VALUES
    ('11111111-1111-1111-1111-111111111001', 'Retro', 'retro', NOW()),
    ('11111111-1111-1111-1111-111111111002', 'Vintage', 'vintage', NOW()),
    ('11111111-1111-1111-1111-111111111003', 'Anime', 'anime', NOW()),
    ('11111111-1111-1111-1111-111111111004', 'Cartoon', 'cartoon', NOW()),
    ('11111111-1111-1111-1111-111111111005', 'Cinematic', 'cinematic', NOW()),
    ('11111111-1111-1111-1111-111111111006', 'Professional', 'professional', NOW()),
    ('11111111-1111-1111-1111-111111111007', 'Art', 'art', NOW())
ON CONFLICT (slug) DO NOTHING;

INSERT INTO templates (
    id, name, slug, category, description, thumbnail_url, prompt, active, trending, created_at
) VALUES
(
    '22222222-2222-2222-2222-222222222001',
    '90s Retro',
    'retro-90s',
    'Retro',
    'Give your portrait a nostalgic 1990s film photography look.',
    'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&q=80',
    'Transform the provided portrait into a realistic nostalgic 1990s film photograph. Preserve the person''s recognizable facial identity and facial structure. Use analog film characteristics, natural skin texture, warm vintage colors, subtle film grain, classic 1990s studio photography, realistic lighting and authentic photographic detail. Do not alter face shape, hairstyle, major facial characteristics, skin tone, or recognizable features. Same person, different visual style.',
    TRUE, TRUE, NOW()
),
(
    '22222222-2222-2222-2222-222222222002',
    '80s Vintage',
    'vintage-80s',
    'Vintage',
    'Warm analog tones with classic 1980s portrait vibes.',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&q=80',
    'Transform the provided portrait into a realistic 1980s vintage photograph. Preserve the person''s recognizable facial identity, facial structure, hairstyle, skin tone and major facial characteristics. Use warm analog tones, soft flash photography feel, subtle grain, period-accurate color grading and authentic photographic detail. Same person, different visual style.',
    TRUE, TRUE, NOW()
),
(
    '22222222-2222-2222-2222-222222222003',
    'Anime Portrait',
    'anime-portrait',
    'Anime',
    'A polished anime-inspired illustration of your likeness.',
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800&q=80',
    'Transform the provided portrait into a high-quality anime-inspired illustration while preserving the person''s recognizable facial characteristics, hairstyle and overall identity. Use clean linework, expressive eyes, detailed shading and polished illustration quality. Do not unnecessarily alter face shape, skin tone or recognizable features. Same person, different visual style.',
    TRUE, TRUE, NOW()
),
(
    '22222222-2222-2222-2222-222222222004',
    'Cartoon',
    'cartoon',
    'Cartoon',
    'Playful cartoon styling while keeping you recognizable.',
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&q=80',
    'Transform the provided portrait into a polished cartoon illustration while preserving the person''s recognizable facial identity, hairstyle and overall look. Use clean shapes, expressive features, soft shading and friendly cartoon styling. Keep skin tone and major facial characteristics recognizable. Same person, different visual style.',
    TRUE, TRUE, NOW()
),
(
    '22222222-2222-2222-2222-222222222005',
    'Cinematic Portrait',
    'cinematic-portrait',
    'Cinematic',
    'Dramatic cinematic lighting and film-still atmosphere.',
    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=800&q=80',
    'Transform the provided portrait into a cinematic film-still photograph. Preserve the person''s recognizable facial identity, facial structure, hairstyle, skin tone and major facial characteristics. Use dramatic cinematic lighting, shallow depth of field, rich contrast and professional color grading. Same person, different visual style.',
    TRUE, FALSE, NOW()
),
(
    '22222222-2222-2222-2222-222222222006',
    'Vintage Film',
    'vintage-film',
    'Vintage',
    'Soft grain and faded film colors for timeless portraits.',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?w=800&q=80',
    'Transform the provided portrait into a timeless vintage film photograph. Preserve the person''s recognizable facial identity, facial structure, hairstyle, skin tone and major facial characteristics. Use soft film grain, gently faded colors, natural highlights and authentic analog photographic detail. Same person, different visual style.',
    TRUE, FALSE, NOW()
),
(
    '22222222-2222-2222-2222-222222222007',
    'Professional Portrait',
    'professional-portrait',
    'Professional',
    'Clean studio lighting for a polished professional look.',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80',
    'Transform the provided portrait into a polished professional studio portrait. Preserve the person''s recognizable facial identity, facial structure, hairstyle, skin tone and major facial characteristics. Use clean studio lighting, natural skin texture, sharp focus and contemporary professional photography style. Same person, different visual style.',
    TRUE, FALSE, NOW()
),
(
    '22222222-2222-2222-2222-222222222008',
    'Watercolor',
    'watercolor',
    'Art',
    'Delicate watercolor brushwork with soft artistic washes.',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=800&q=80',
    'Transform the provided portrait into a delicate watercolor painting while preserving the person''s recognizable facial characteristics, hairstyle and overall identity. Use soft washes, gentle pigment blooms, paper texture and refined artistic brushwork. Keep face shape, skin tone and recognizable features intact. Same person, different visual style.',
    TRUE, FALSE, NOW()
),
(
    '22222222-2222-2222-2222-222222222009',
    'Comic Art',
    'comic-art',
    'Cartoon',
    'Bold comic-book lines, ink, and graphic shading.',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800&q=80',
    'Transform the provided portrait into a bold comic-book illustration while preserving the person''s recognizable facial identity, hairstyle and overall look. Use strong ink outlines, graphic shading, halftone accents and polished comic-art styling. Keep major facial characteristics and skin tone recognizable. Same person, different visual style.',
    TRUE, FALSE, NOW()
),
(
    '22222222-2222-2222-2222-222222222010',
    'Royal Portrait',
    'royal-portrait',
    'Art',
    'Regal classical portrait styling with rich detail.',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&q=80',
    'Transform the provided portrait into a regal classical oil-painting style portrait while preserving the person''s recognizable facial identity, facial structure, hairstyle, skin tone and major facial characteristics. Use rich detail, elegant lighting, painterly texture and classical portrait composition. Same person, different visual style.',
    TRUE, FALSE, NOW()
)
ON CONFLICT (slug) DO NOTHING;
