-- First remove RLS policies
DROP POLICY IF EXISTS "Users can view their own grades" ON gt_grades;
DROP POLICY IF EXISTS "Users can insert their own grades" ON gt_grades;
DROP POLICY IF EXISTS "Users can update their own grades" ON gt_grades;
DROP POLICY IF EXISTS "Users can delete their own grades" ON gt_grades;

DROP POLICY IF EXISTS "Users can view their own grade categories" ON gt_grade_categories;
DROP POLICY IF EXISTS "Users can insert their own grade categories" ON gt_grade_categories;
DROP POLICY IF EXISTS "Users can update their own grade categories" ON gt_grade_categories;
DROP POLICY IF EXISTS "Users can delete their own grade categories" ON gt_grade_categories;

DROP POLICY IF EXISTS "Users can view their own courses" ON gt_course_tracking;
DROP POLICY IF EXISTS "Users can insert their own courses" ON gt_course_tracking;
DROP POLICY IF EXISTS "Users can update their own courses" ON gt_course_tracking;
DROP POLICY IF EXISTS "Users can delete their own courses" ON gt_course_tracking;

-- Remove triggers to avoid dependency issues
DROP TRIGGER IF EXISTS update_gt_grades_timestamp ON gt_grades;
DROP TRIGGER IF EXISTS update_gt_grade_categories_timestamp ON gt_grade_categories;
DROP TRIGGER IF EXISTS update_gt_course_tracking_timestamp ON gt_course_tracking;

-- Remove tables in reverse order of creation to respect foreign key constraints
DROP TABLE IF EXISTS gt_grades;
DROP TABLE IF EXISTS gt_grade_categories;
DROP TABLE IF EXISTS gt_course_tracking;

-- Remove the trigger function (after removing all triggers that use it)
DROP FUNCTION IF EXISTS update_timestamp();

-- Indexes should be automatically dropped with their tables