-- Grade Tracking Tables for Supabase

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Course Tracking Table
CREATE TABLE gt_course_tracking (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  student_code TEXT NOT NULL,
  course_code TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (course_code, student_code, id)
);

-- Index for faster lookups by student_code and course_code
CREATE UNIQUE INDEX idx_gt_course_tracking_student_course ON gt_course_tracking(student_code, course_code);
-- Grade Categories Table
CREATE TABLE gt_grade_categories (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  course_tracking_id UUID NOT NULL REFERENCES gt_course_tracking(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  weight REAL NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for faster lookups by course_tracking_id
CREATE INDEX idx_gt_grade_categories_course_id ON gt_grade_categories(course_tracking_id);

-- Grades Table
CREATE TABLE gt_grades (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  category_id UUID NOT NULL REFERENCES gt_grade_categories(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  score REAL NOT NULL,
  enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for faster lookups by category_id
CREATE INDEX idx_gt_grades_category_id ON gt_grades(category_id);

-- Create Row-Level Security Policies
-- Enable RLS on all tables
ALTER TABLE gt_course_tracking ENABLE ROW LEVEL SECURITY;
ALTER TABLE gt_grade_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE gt_grades ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add triggers for updated_at fields
CREATE TRIGGER update_gt_course_tracking_timestamp
BEFORE UPDATE ON gt_course_tracking
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_gt_grade_categories_timestamp
BEFORE UPDATE ON gt_grade_categories
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_gt_grades_timestamp
BEFORE UPDATE ON gt_grades
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();