-- Migration: Add player_milestones table
-- Run this in Supabase Dashboard > SQL Editor > New query

-- ============================================
-- PLAYER MILESTONES TABLE (Progress tracking for predefined milestones)
-- ============================================
CREATE TABLE IF NOT EXISTS player_milestones (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    milestone_id TEXT NOT NULL, -- References predefined milestone definitions in app

    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMPTZ,
    notes TEXT,
    media_url TEXT,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(player_id, milestone_id)
);

-- Enable RLS
ALTER TABLE player_milestones ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "Users can view own player milestones" ON player_milestones
    FOR SELECT USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can insert own player milestones" ON player_milestones
    FOR INSERT WITH CHECK (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can update own player milestones" ON player_milestones
    FOR UPDATE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

CREATE POLICY "Users can delete own player milestones" ON player_milestones
    FOR DELETE USING (
        player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
    );

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_player_milestones_player_id ON player_milestones(player_id);
CREATE INDEX IF NOT EXISTS idx_player_milestones_milestone_id ON player_milestones(milestone_id);

-- Trigger for updated_at (assumes the update_updated_at_column function already exists)
CREATE TRIGGER update_player_milestones_updated_at
    BEFORE UPDATE ON player_milestones
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
