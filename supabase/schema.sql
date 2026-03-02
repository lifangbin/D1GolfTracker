-- HappyGolf Database Schema
-- Run this in Supabase SQL Editor (Dashboard > SQL Editor > New query)

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- PLAYERS TABLE
-- ============================================
CREATE TABLE players (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    gender TEXT CHECK (gender IN ('male', 'female', 'other')),
    avatar_url TEXT,

    -- Golf Australia Integration
    ga_number TEXT,
    ga_connected BOOLEAN DEFAULT FALSE,
    ga_last_sync TIMESTAMPTZ,

    -- Current Stats
    current_handicap DECIMAL(4,1),
    current_phase INTEGER DEFAULT 1 CHECK (current_phase BETWEEN 1 AND 4),
    home_course TEXT,

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(user_id)
);

-- Enable RLS
ALTER TABLE players ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own player" ON players
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own player" ON players
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own player" ON players
    FOR UPDATE USING (auth.uid() = user_id);

-- ============================================
-- HANDICAP HISTORY TABLE
-- ============================================
CREATE TABLE handicap_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    handicap_index DECIMAL(4,1) NOT NULL,
    low_handicap DECIMAL(4,1),
    effective_date DATE NOT NULL,
    source TEXT CHECK (source IN ('ga_connect', 'manual', 'calculated')),
    rounds_counted INTEGER,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE handicap_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own handicap history" ON handicap_history
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own handicap history" ON handicap_history
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- TOURNAMENTS TABLE
-- ============================================
CREATE TABLE tournaments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,

    -- Basic Info
    name TEXT NOT NULL,
    tournament_type TEXT CHECK (tournament_type IN ('local', 'regional', 'state', 'national', 'international')),
    start_date DATE NOT NULL,
    end_date DATE,

    -- Location
    course_name TEXT NOT NULL,
    course_city TEXT,
    course_state TEXT,
    course_country TEXT DEFAULT 'Australia',
    course_par INTEGER,
    course_slope DECIMAL(5,1),
    course_rating DECIMAL(4,1),

    -- Results
    total_score INTEGER,
    position INTEGER,
    field_size INTEGER,
    score_to_par INTEGER,

    -- Notes
    notes TEXT,
    weather_conditions TEXT,

    -- Timestamps
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own tournaments" ON tournaments
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own tournaments" ON tournaments
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can update own tournaments" ON tournaments
    FOR UPDATE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can delete own tournaments" ON tournaments
    FOR DELETE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- ROUNDS TABLE
-- ============================================
CREATE TABLE rounds (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,

    round_number INTEGER DEFAULT 1,
    round_date DATE NOT NULL,

    -- Course Info (may differ from tournament)
    course_name TEXT,
    tee_played TEXT,
    course_par INTEGER,
    course_slope DECIMAL(5,1),
    course_rating DECIMAL(4,1),

    -- Scores
    gross_score INTEGER NOT NULL,
    net_score INTEGER,
    differential DECIMAL(4,1),

    -- Stats
    fairways_hit INTEGER,
    fairways_total INTEGER,
    greens_in_regulation INTEGER,
    putts INTEGER,

    -- Penalties
    penalties INTEGER DEFAULT 0,

    -- Flags
    is_practice BOOLEAN DEFAULT FALSE,
    is_counted_for_handicap BOOLEAN DEFAULT TRUE,

    notes TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE rounds ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own rounds" ON rounds
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own rounds" ON rounds
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can update own rounds" ON rounds
    FOR UPDATE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can delete own rounds" ON rounds
    FOR DELETE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- HOLE SCORES TABLE
-- ============================================
CREATE TABLE hole_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    round_id UUID NOT NULL REFERENCES rounds(id) ON DELETE CASCADE,

    hole_number INTEGER NOT NULL CHECK (hole_number BETWEEN 1 AND 18),
    par INTEGER NOT NULL CHECK (par BETWEEN 3 AND 5),
    stroke_index INTEGER CHECK (stroke_index BETWEEN 1 AND 18),

    strokes INTEGER NOT NULL,
    putts INTEGER,
    fairway_hit BOOLEAN,
    green_in_regulation BOOLEAN,
    sand_save BOOLEAN,
    up_and_down BOOLEAN,
    penalty_strokes INTEGER DEFAULT 0,

    notes TEXT,

    UNIQUE(round_id, hole_number)
);

-- Enable RLS
ALTER TABLE hole_scores ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own hole scores" ON hole_scores
    FOR SELECT USING (
        round_id IN (
            SELECT id FROM rounds WHERE player_id IN (
                SELECT id FROM players WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can insert own hole scores" ON hole_scores
    FOR INSERT WITH CHECK (
        round_id IN (
            SELECT id FROM rounds WHERE player_id IN (
                SELECT id FROM players WHERE user_id = auth.uid()
            )
        )
    );

CREATE POLICY "Users can update own hole scores" ON hole_scores
    FOR UPDATE USING (
        round_id IN (
            SELECT id FROM rounds WHERE player_id IN (
                SELECT id FROM players WHERE user_id = auth.uid()
            )
        )
    );

-- ============================================
-- MEDIA ITEMS TABLE
-- ============================================
CREATE TABLE media_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE SET NULL,
    round_id UUID REFERENCES rounds(id) ON DELETE SET NULL,

    media_type TEXT NOT NULL CHECK (media_type IN ('photo', 'video')),
    storage_path TEXT NOT NULL,
    thumbnail_path TEXT,

    title TEXT,
    description TEXT,
    tags TEXT[],

    -- Metadata
    file_size INTEGER,
    duration_seconds INTEGER, -- for videos
    width INTEGER,
    height INTEGER,

    captured_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE media_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own media" ON media_items
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own media" ON media_items
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can delete own media" ON media_items
    FOR DELETE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- TRAINING LOGS TABLE
-- ============================================
CREATE TABLE training_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,

    training_date DATE NOT NULL,
    duration_minutes INTEGER,

    training_type TEXT CHECK (training_type IN ('range', 'short_game', 'putting', 'course', 'fitness', 'mental', 'lesson')),
    focus_areas TEXT[],

    coach_name TEXT,
    location TEXT,

    notes TEXT,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE training_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own training logs" ON training_logs
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own training logs" ON training_logs
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can update own training logs" ON training_logs
    FOR UPDATE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can delete own training logs" ON training_logs
    FOR DELETE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- MILESTONES TABLE
-- ============================================
CREATE TABLE milestones (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,

    title TEXT NOT NULL,
    description TEXT,
    milestone_type TEXT CHECK (milestone_type IN ('handicap', 'tournament', 'skill', 'academic', 'phase', 'custom')),

    achieved_date DATE,
    target_date DATE,
    is_completed BOOLEAN DEFAULT FALSE,

    -- For phase milestones
    phase_number INTEGER,

    -- For handicap milestones
    target_handicap DECIMAL(4,1),
    achieved_handicap DECIMAL(4,1),

    notes TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE milestones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own milestones" ON milestones
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own milestones" ON milestones
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can update own milestones" ON milestones
    FOR UPDATE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- ============================================
-- USER COURSES TABLE (manually added courses)
-- ============================================
CREATE TABLE user_courses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,

    name TEXT NOT NULL,
    city TEXT,
    state TEXT,
    country TEXT DEFAULT 'Australia',

    par INTEGER,
    slope_rating DECIMAL(5,1),
    course_rating DECIMAL(4,1),

    tee_name TEXT,
    tee_color TEXT,

    is_favorite BOOLEAN DEFAULT FALSE,

    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE user_courses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own courses" ON user_courses
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own courses" ON user_courses
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own courses" ON user_courses
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own courses" ON user_courses
    FOR DELETE USING (auth.uid() = user_id);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX idx_players_user_id ON players(user_id);
CREATE INDEX idx_handicap_history_player_id ON handicap_history(player_id);
CREATE INDEX idx_handicap_history_date ON handicap_history(effective_date DESC);
CREATE INDEX idx_tournaments_player_id ON tournaments(player_id);
CREATE INDEX idx_tournaments_date ON tournaments(start_date DESC);
CREATE INDEX idx_rounds_player_id ON rounds(player_id);
CREATE INDEX idx_rounds_tournament_id ON rounds(tournament_id);
CREATE INDEX idx_rounds_date ON rounds(round_date DESC);
CREATE INDEX idx_media_items_player_id ON media_items(player_id);
CREATE INDEX idx_media_items_tournament_id ON media_items(tournament_id);
CREATE INDEX idx_training_logs_player_id ON training_logs(player_id);
CREATE INDEX idx_training_logs_date ON training_logs(training_date DESC);
CREATE INDEX idx_milestones_player_id ON milestones(player_id);
CREATE INDEX idx_user_courses_user_id ON user_courses(user_id);

-- ============================================
-- UPDATED_AT TRIGGER FUNCTION
-- ============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers
CREATE TRIGGER update_players_updated_at
    BEFORE UPDATE ON players
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_tournaments_updated_at
    BEFORE UPDATE ON tournaments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_rounds_updated_at
    BEFORE UPDATE ON rounds
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_milestones_updated_at
    BEFORE UPDATE ON milestones
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- STORAGE BUCKETS (run separately or via Dashboard)
-- ============================================
-- Note: Create these via Supabase Dashboard > Storage > New bucket
-- 1. tournament-media (public: false)
-- 2. avatars (public: true)
