-- =============================================
-- FARMINGTON COUNTRY CLUB - EXPANDED CMS SCHEMA
-- =============================================
-- Run this in the Supabase SQL Editor
-- This adds new tables for full site management
-- =============================================

-- 1. COURSE RATINGS (8 rating/slope pairs)
CREATE TABLE IF NOT EXISTS course_ratings (
    id SERIAL PRIMARY KEY,
    gender TEXT NOT NULL CHECK (gender IN ('male', 'female')),
    tee_name TEXT NOT NULL,
    rating DECIMAL(4,1) NOT NULL,
    slope INTEGER NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. COURSE INFO CARDS (6 cards)
CREATE TABLE IF NOT EXISTS course_info (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    icon TEXT NOT NULL,
    content TEXT NOT NULL,
    has_button BOOLEAN DEFAULT false,
    button_text TEXT,
    button_link TEXT,
    sort_order INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. PRO SHOP SERVICES
CREATE TABLE IF NOT EXISTS pro_shop_services (
    id SERIAL PRIMARY KEY,
    service_name TEXT NOT NULL,
    sort_order INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- ENABLE ROW LEVEL SECURITY
-- =============================================

ALTER TABLE course_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE course_info ENABLE ROW LEVEL SECURITY;
ALTER TABLE pro_shop_services ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access" ON course_ratings FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON course_info FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON pro_shop_services FOR SELECT USING (true);

-- =============================================
-- SEED COURSE RATINGS
-- =============================================

INSERT INTO course_ratings (gender, tee_name, rating, slope, sort_order) VALUES
('male', 'White/Blue', 69.9, 127, 1),
('male', 'Black Tops', 69.2, 125, 2),
('male', 'Green Tops', 66.6, 117, 3),
('male', 'Red/Gold', 65.6, 108, 4),
('female', 'White/Blue', 76.3, 131, 5),
('female', 'Black Tops', 75.4, 127, 6),
('female', 'Green Tops', 72.2, 124, 7),
('female', 'Red/Gold', 70.3, 118, 8);

-- =============================================
-- SEED COURSE INFO CARDS
-- =============================================

INSERT INTO course_info (title, icon, content, has_button, button_text, button_link, sort_order) VALUES
('Course Rating/Slope', '⛳', 'RATINGS_DISPLAY', true, 'View Scorecard', '#scorecard', 1),
('Tee Times', '🏌️', 'Required on weekends and holidays. Members can book up to 1 week in advance. Non-members can book 5 days ahead.', true, 'Book a Tee Time', 'https://fox.tenfore.golf/farmington', 2),
('Golf Carts', '🚗', 'Power carts available. Must have valid driver''s license. Keep carts on paths when possible and 30ft from greens.', false, NULL, NULL, 3),
('Dress Code', '👕', 'Shirts and shoes required. No tank tops, bathing suits, or offensive attire. Pro shop decision is final.', false, NULL, NULL, 4),
('Pace of Play', '⏱️', 'Course should be played in just over 2 hours for 9 holes. Play ready golf and stay behind the group ahead.', false, NULL, NULL, 5),
('Local Rules', '📋', 'USGA rules govern play. Preferred lies in fairways (1 club length). All staked trees are mandatory free lift.', false, NULL, NULL, 6);

-- =============================================
-- SEED PRO SHOP SERVICES
-- =============================================

INSERT INTO pro_shop_services (service_name, sort_order) VALUES
('Club Re-Gripping', 1),
('Shoe Re-Spiking', 2),
('Private Lessons', 3),
('Equipment Sales', 4),
('Apparel', 5),
('Beverages', 6);

-- =============================================
-- ADD NEW SITE SETTINGS
-- =============================================

INSERT INTO site_settings (key, value) VALUES
-- About Section
('about_heading', 'Welcome to FCC'),
('about_text_1', 'Founded in 1924, Farmington Country Club is a nine-hole par 36 golf course located on the bank of the Cocheco River. We pride ourselves on offering our members excellent playing conditions, a welcoming atmosphere, and competitive tournaments throughout the season.'),
('about_text_2', 'Whether you''re a seasoned golfer or just starting out, FCC offers something for everyone. Our course challenges players of all skill levels while remaining approachable and enjoyable.'),
('about_image_text', '100 Years'),
('about_image_subtext', 'of Golf Excellence'),
-- Club Stats
('stat_established', '1924'),
('stat_holes', '9'),
('stat_par', '36'),
-- Hero
('hero_tagline', 'A nine-hole hidden gem on the banks of the Cocheco River'),
('tee_time_url', 'https://fox.tenfore.golf/farmington'),
-- Contact Info
('contact_address_line1', '181 Main Street'),
('contact_address_line2', 'Farmington, NH 03835'),
('contact_phone', '(603) 755-2412'),
('contact_email', 'fcc@metrocast.net'),
('facebook_url', 'https://www.facebook.com/FarmingtonCountryClubNH/'),
('instagram_url', 'https://www.instagram.com/farmingtoncountryclubnh/'),
-- Pro Shop
('proshop_heading', 'The Pro Shop'),
('proshop_text_1', 'Our fully stocked Pro Shop has everything you need for your round. We offer equipment, apparel, accessories, and professional services to keep your game sharp.'),
('proshop_text_2', 'The shop opens no later than April 1st each season (earlier if weather permits). After November 15th, the course remains open for members only until winter conditions force closure.'),
-- Admin
('admin_password', 'Farmington@1924!')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;
