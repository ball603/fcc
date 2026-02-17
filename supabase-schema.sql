-- =============================================
-- FARMINGTON COUNTRY CLUB - SUPABASE SCHEMA
-- =============================================
-- Run this in the Supabase SQL Editor
-- =============================================

-- 1. ANNOUNCEMENTS
-- Controls the banner at the top of the site
CREATE TABLE announcements (
    id SERIAL PRIMARY KEY,
    message TEXT NOT NULL,
    link_text TEXT,
    link_url TEXT,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. SCORECARD
-- Course scorecard data for all holes and tee boxes
CREATE TABLE scorecard (
    id SERIAL PRIMARY KEY,
    hole INTEGER NOT NULL CHECK (hole >= 1 AND hole <= 9),
    par INTEGER NOT NULL,
    white_blue INTEGER,
    black_tops INTEGER,
    back_hcp INTEGER,
    green_tops INTEGER,
    red_gold INTEGER,
    fwd_hcp INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(hole)
);

-- 3. RATES
-- Membership fees, greens fees, cart fees
CREATE TABLE rates (
    id SERIAL PRIMARY KEY,
    category TEXT NOT NULL CHECK (category IN ('membership', 'greens', 'cart')),
    type TEXT NOT NULL,
    price INTEGER NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. LEAGUES
-- League information for the Leagues section
CREATE TABLE leagues (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    blurb TEXT,
    day TEXT,
    rate TEXT,
    contact1_name TEXT,
    contact1_email TEXT,
    contact2_name TEXT,
    contact2_email TEXT,
    button_text TEXT DEFAULT 'Learn More',
    button_link TEXT,
    button_style TEXT DEFAULT 'secondary',
    sort_order INTEGER DEFAULT 0,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. SITE SETTINGS
-- Key-value pairs for site configuration
CREATE TABLE site_settings (
    id SERIAL PRIMARY KEY,
    key TEXT NOT NULL UNIQUE,
    value TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- ENABLE ROW LEVEL SECURITY (RLS)
-- =============================================

ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
ALTER TABLE scorecard ENABLE ROW LEVEL SECURITY;
ALTER TABLE rates ENABLE ROW LEVEL SECURITY;
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access (anon users can read)
CREATE POLICY "Allow public read access" ON announcements FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON scorecard FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON rates FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON leagues FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON site_settings FOR SELECT USING (true);

-- =============================================
-- SEED DATA
-- =============================================

-- Announcement (current winter message)
INSERT INTO announcements (message, link_text, link_url, active) VALUES
('⛳ Thank you for a great season. Enjoy the winter and we''ll see you when the clubhouse opens on April 1st.', NULL, NULL, true);

-- Scorecard data (9 holes)
INSERT INTO scorecard (hole, par, white_blue, black_tops, back_hcp, green_tops, red_gold, fwd_hcp) VALUES
(1, 4, 369, 351, 3, 329, 305, 5),
(2, 5, 496, 468, 1, 438, 419, 1),
(3, 4, 323, 315, 7, 276, 253, 7),
(4, 3, 149, 141, 9, 121, 117, 9),
(5, 4, 330, 320, 5, 287, 268, 3),
(6, 4, 339, 328, 4, 298, 286, 4),
(7, 4, 292, 285, 8, 259, 247, 8),
(8, 3, 175, 167, 6, 137, 125, 6),
(9, 5, 460, 450, 2, 413, 386, 2);

-- Membership rates
INSERT INTO rates (category, type, price, sort_order) VALUES
('membership', 'Annual Membership (30-64)', 750, 1),
('membership', 'Senior Membership (65+)', 700, 2),
('membership', 'Husband & Wife', 1300, 3),
('membership', 'Young Professional (23-29)', 500, 4),
('membership', 'Young Adult (18-22)', 300, 5),
('membership', 'Junior (12-17)', 150, 6);

-- Greens fees
INSERT INTO rates (category, type, price, sort_order) VALUES
('greens', '9 Holes (Weekday)', 25, 1),
('greens', '9 Holes (Weekend)', 30, 2),
('greens', '18 Holes (Weekday)', 40, 3),
('greens', '18 Holes (Weekend)', 50, 4),
('greens', 'Twilight (after 5pm)', 20, 5);

-- Cart fees
INSERT INTO rates (category, type, price, sort_order) VALUES
('cart', '9 Holes', 12, 1),
('cart', '18 Holes', 20, 2);

-- Leagues
INSERT INTO leagues (name, blurb, day, rate, contact1_name, contact1_email, contact2_name, contact2_email, button_text, button_link, button_style, sort_order) VALUES
('Men''s League', 'Competitive 9-hole league with weekly prizes and end-of-season tournament.', 'Tuesdays', '$25/week', 'John Smith', 'mensleague@fccgolf.com', NULL, NULL, 'View Standings', '/mens-league-2025.html', 'primary', 1),
('Ladies'' League', 'Fun and friendly 9-hole league welcoming all skill levels.', 'Wednesdays', '$20/week', 'Jane Doe', 'ladiesleague@fccgolf.com', NULL, NULL, 'Learn More', NULL, 'secondary', 2),
('Couples'' League', 'Mixed league for couples to enjoy golf together.', 'Thursdays', '$30/couple', 'Bob Wilson', 'couplesleague@fccgolf.com', NULL, NULL, 'Learn More', NULL, 'secondary', 3),
('Senior League', 'Weekday morning league for seniors 55+.', 'Fridays', '$15/week', 'Tom Brown', 'seniorleague@fccgolf.com', NULL, NULL, 'Learn More', NULL, 'secondary', 4);

-- Site settings
INSERT INTO site_settings (key, value) VALUES
('membership_open', 'true'),
('rates_year', '2025'),
('season_status', 'closed'),
('clubhouse_opens', 'April 1st');
