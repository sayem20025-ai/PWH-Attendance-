-- ============================================
-- Worth Hotel HK Attendance System
-- Run this in Supabase SQL Editor
-- ============================================

-- EMPLOYEES TABLE
CREATE TABLE employees (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  employee_id TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT,
  department TEXT,
  shift_start TIME NOT NULL DEFAULT '09:00',
  shift_end TIME NOT NULL DEFAULT '17:00',
  role TEXT DEFAULT 'employee', -- 'employee' or 'admin'
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ATTENDANCE TABLE
CREATE TABLE attendance (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  employee_id TEXT NOT NULL REFERENCES employees(employee_id),
  full_name TEXT,
  department TEXT,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  check_in TIME,
  check_out TIME,
  check_in_lat FLOAT,
  check_in_lng FLOAT,
  is_late BOOLEAN DEFAULT false,
  hours_worked FLOAT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(employee_id, date)
);

-- DEVICE REGISTRY TABLE
CREATE TABLE devices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  employee_id TEXT NOT NULL REFERENCES employees(employee_id),
  device_fingerprint TEXT NOT NULL,
  registered_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(employee_id)
);

-- ROW LEVEL SECURITY
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;
ALTER TABLE devices ENABLE ROW LEVEL SECURITY;

CREATE POLICY "allow_all_employees" ON employees FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_attendance" ON attendance FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "allow_all_devices" ON devices FOR ALL USING (true) WITH CHECK (true);

-- INSERT DEFAULT ADMIN
INSERT INTO employees (employee_id, full_name, email, role, shift_start, shift_end)
VALUES ('ADMIN001', 'Administrator', 'sayem20025@gmail.com', 'admin', '00:00', '23:59');
