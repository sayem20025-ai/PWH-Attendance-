-- Run this in Supabase SQL Editor to add new columns
ALTER TABLE attendance ADD COLUMN IF NOT EXISTS status TEXT;
ALTER TABLE attendance ADD COLUMN IF NOT EXISTS note TEXT;
