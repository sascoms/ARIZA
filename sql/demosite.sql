-- Host: localhost
-- Generation Time: Oct 20, 2009 at 04:33 PM
-- Server version: 5.0.51
-- PHP Version: 5.2.11-1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `arizadb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bugs`
--

CREATE TABLE IF NOT EXISTS `bugs` (
  `bug_id` int(11) NOT NULL auto_increment,
  `bug_code` varchar(32) collate utf8_unicode_ci NOT NULL,
  `project_id` int(11) NOT NULL default '0',
  `bug_type_id` int(11) NOT NULL default '0',
  `reporting_staff_id` int(11) NOT NULL default '0',
  `replying_staff_id` int(255) NOT NULL default '0',
  `bug_title` varchar(255) collate utf8_unicode_ci NOT NULL,
  `bug_description` text collate utf8_unicode_ci NOT NULL,
  `bug_steps` text collate utf8_unicode_ci NOT NULL,
  `possible_solution` varchar(255) collate utf8_unicode_ci NOT NULL,
  `uploaded_file` varchar(255) collate utf8_unicode_ci NOT NULL,
  `bug_priority` int(11) NOT NULL default '0',
  `status` int(11) NOT NULL default '1',
  `is_solved` int(11) NOT NULL default '0',
  `progress_percent` int(11) NOT NULL default '0',
  `reported_datetime` datetime NOT NULL default '0000-00-00 00:00:00',
  `solved_datetime` datetime NOT NULL default '0000-00-00 00:00:00',
  `mailcc` varchar(255) collate utf8_unicode_ci NOT NULL,
  `solve_duration` varchar(5) collate utf8_unicode_ci NOT NULL,
  `project_version_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`bug_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `bugs`
--

INSERT INTO `bugs` (`bug_id`, `bug_code`, `project_id`, `bug_type_id`, `reporting_staff_id`, `replying_staff_id`, `bug_title`, `bug_description`, `bug_steps`, `possible_solution`, `uploaded_file`, `bug_priority`, `status`, `is_solved`, `progress_percent`, `reported_datetime`, `solved_datetime`, `mailcc`, `solve_duration`, `project_version_id`) VALUES
(1, '7E3B35', 1, 1, 1, 3, 'Testing bug request', 'This is a bug request test.', 'these are the steps taht caused the problem.', 'here are the suggessted solutions...', '', 3, 1, 0, 0, '2009-10-20 16:17:49', '0000-00-00 00:00:00', '', '', 1),
(2, '7E8CF5', 1, 3, 1, 2, 'Testing bug request - 2', 'This is a bug request test.  - 2', 'these are the steps taht caused the problem.  - 2', 'here are the suggessted solutions... - 2', '', 2, 2, 0, 35, '2009-10-20 16:18:09', '0000-00-00 00:00:00', '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `bug_types`
--

CREATE TABLE IF NOT EXISTS `bug_types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(25) collate utf8_unicode_ci NOT NULL,
  `project_id` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `bug_types`
--

INSERT INTO `bug_types` (`id`, `name`, `project_id`) VALUES
(1, 'Operator related', 1),
(2, 'User related', 1),
(3, 'Design/Interface/Content', 1),
(4, 'Database related', 1),
(5, 'Hardware', 0),
(6, 'Maintenance', 0);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` tinyint(4) NOT NULL default '0',
  `name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `description` varchar(100) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `groups`
--


-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE IF NOT EXISTS `options` (
  `id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '1',
  `optionname` varchar(55) collate utf8_unicode_ci NOT NULL,
  `optionvalue` varchar(55) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `optionname` (`optionname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `project_id`, `optionname`, `optionvalue`) VALUES
(1, 1, 'site_template', 'multiflex'),
(2, 1, 'site_language', 'en_US'),
(3, 1, 'site_title', 'ARIZA: Helpdesk'),
(4, 1, 'site_header', 'ARIZA'),
(5, 1, 'site_slogan', 'Simple. Simple. Simple');

-- --------------------------------------------------------

--
-- Table structure for table `priorities`
--

CREATE TABLE IF NOT EXISTS `priorities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(25) collate utf8_unicode_ci NOT NULL,
  `project_id` tinyint(4) NOT NULL default '0',
  `color` varchar(7) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `priorities`
--

INSERT INTO `priorities` (`id`, `name`, `project_id`, `color`) VALUES
(1, 'Level 1', 1, '#FF0000'),
(2, 'Level 2', 1, '#0033CC'),
(3, 'Level 3', 1, '#993300'),
(4, 'Level 4', 1, '#FF00CC'),
(12, 'Level 5', 0, '#009999');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `project_id` tinyint(4) NOT NULL default '0',
  `name` varchar(20) collate utf8_unicode_ci NOT NULL,
  `description` varchar(100) collate utf8_unicode_ci NOT NULL,
  `is_active` char(1) collate utf8_unicode_ci NOT NULL,
  `is_deleted` char(1) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`project_id`, `name`, `description`, `is_active`, `is_deleted`) VALUES
(1, 'ARIZA', 'ariza bugtracking tool1', '1', '0'),
(2, 'BUGTRACKER', 'classic bug tracking tool', '1', '0'),
(4, 'TEST II', 'Second Test Project', '1', '0'),
(3, 'TEST', 'A test project', '1', '0');

-- --------------------------------------------------------

--
-- Table structure for table `projects_users`
--

CREATE TABLE IF NOT EXISTS `projects_users` (
  `id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `user_id` int(11) NOT NULL default '0',
  `createdatetime` datetime NOT NULL default '0000-00-00 00:00:00',
  `extra` varchar(11) collate utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `projects_users`
--

INSERT INTO `projects_users` (`id`, `project_id`, `user_id`, `createdatetime`, `extra`) VALUES
(1, 1, 1, '0000-00-00 00:00:00', ''),
(2, 2, 1, '0000-00-00 00:00:00', ''),
(3, 1, 2, '0000-00-00 00:00:00', ''),
(4, 2, 3, '0000-00-00 00:00:00', ''),
(5, 4, 1, '0000-00-00 00:00:00', ''),
(6, 4, 2, '0000-00-00 00:00:00', ''),
(7, 4, 3, '0000-00-00 00:00:00', ''),
(8, 3, 1, '0000-00-00 00:00:00', ''),
(9, 3, 2, '0000-00-00 00:00:00', ''),
(10, 3, 3, '0000-00-00 00:00:00', ''),
(11, 2, 4, '0000-00-00 00:00:00', ''),
(12, 4, 4, '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `responses`
--

CREATE TABLE IF NOT EXISTS `responses` (
  `response_id` int(11) NOT NULL default '0',
  `bug_id` int(11) NOT NULL default '0',
  `auth_staff_id` int(11) NOT NULL default '0',
  `replying_staff_id` int(255) NOT NULL default '0',
  `response_text` text collate utf8_unicode_ci NOT NULL,
  `response_status` int(11) NOT NULL default '0',
  `response_datetime` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`response_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `responses`
--

INSERT INTO `responses` (`response_id`, `bug_id`, `auth_staff_id`, `replying_staff_id`, `response_text`, `response_status`, `response_datetime`) VALUES
(1, 2, 0, 1, 'checking problem...', 1, '2009-10-20 16:18:39'),
(2, 2, 0, 1, 'got the request to waiting status...', 2, '2009-10-20 16:18:58');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE IF NOT EXISTS `staff` (
  `staff_id` int(11) NOT NULL auto_increment,
  `staff_user` varchar(20) collate utf8_unicode_ci NOT NULL,
  `staff_pass` varchar(32) collate utf8_unicode_ci NOT NULL,
  `staff_name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `staff_surname` varchar(255) collate utf8_unicode_ci NOT NULL,
  `staff_email` varchar(255) collate utf8_unicode_ci NOT NULL,
  `staff_type` varchar(15) collate utf8_unicode_ci NOT NULL,
  `is_admin` char(1) collate utf8_unicode_ci default NULL,
  `default_project_id` int(11) NOT NULL default '0',
  `status` char(1) collate utf8_unicode_ci NOT NULL default '1',
  `is_deleted` char(1) collate utf8_unicode_ci NOT NULL default '0',
  PRIMARY KEY  (`staff_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=37 ;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_user`, `staff_pass`, `staff_name`, `staff_surname`, `staff_email`, `staff_type`, `is_admin`, `default_project_id`, `status`, `is_deleted`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Eser', 'SAHiLLiOGLU', 'eser@localhost', 'tech', '1', 1, '1', '0'),
(2, 'demet', '9bc8d6f50e86a9b2082fe3961a55b128', 'Demet', 'ATANAY', 'test@example.com', 'tech', '0', 1, '1', '0'),
(3, 'berrak', '21232f297a57a5a743894a0e4a801fc3', 'Berrak', 'ODUNCU', 'test@example.com', 'tech', '0', 0, '1', '0'),
(4, 'testuser', '5d9c68c6c50ed3d02a2fcf54f63993b6', 'test', 'user', 'test@localhost', 'tech', '0', 4, '1', '0');

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(25) collate utf8_unicode_ci NOT NULL,
  `project_id` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`, `project_id`) VALUES
(1, 'Open', 1),
(2, 'Waiting', 1),
(3, 'Test', 1),
(4, 'Closed', 1);

-- --------------------------------------------------------

--
-- Table structure for table `versions`
--

CREATE TABLE IF NOT EXISTS `versions` (
  `version_id` int(11) NOT NULL default '0',
  `project_id` int(11) NOT NULL default '0',
  `version_title` varchar(64) collate utf8_unicode_ci NOT NULL,
  `version_desc` varchar(255) collate utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `versions`
--

INSERT INTO `versions` (`version_id`, `project_id`, `version_title`, `version_desc`) VALUES
(1, 1, '0.8', 'beta version'),
(2, 1, '0.9', 'pre release');

-- --------------------------------------------------------

--
-- Table structure for table `_seq_bug_id`
--

CREATE TABLE IF NOT EXISTS `_seq_bug_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `_seq_bug_id`
--

INSERT INTO `_seq_bug_id` (`sequence`) VALUES
(2);

-- --------------------------------------------------------

--
-- Table structure for table `_seq_priority_id`
--

CREATE TABLE IF NOT EXISTS `_seq_priority_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `_seq_priority_id`
--


-- --------------------------------------------------------

--
-- Table structure for table `_seq_project_id`
--

CREATE TABLE IF NOT EXISTS `_seq_project_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `_seq_project_id`
--

INSERT INTO `_seq_project_id` (`sequence`) VALUES
(4);

-- --------------------------------------------------------

--
-- Table structure for table `_seq_pr_us_id`
--

CREATE TABLE IF NOT EXISTS `_seq_pr_us_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=14 ;

--
-- Dumping data for table `_seq_pr_us_id`
--

INSERT INTO `_seq_pr_us_id` (`sequence`) VALUES
(13);

-- --------------------------------------------------------

--
-- Table structure for table `_seq_response_id`
--

CREATE TABLE IF NOT EXISTS `_seq_response_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `_seq_response_id`
--

INSERT INTO `_seq_response_id` (`sequence`) VALUES
(2);

-- --------------------------------------------------------

--
-- Table structure for table `_seq_user_id`
--

CREATE TABLE IF NOT EXISTS `_seq_user_id` (
  `sequence` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`sequence`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `_seq_user_id`
--

INSERT INTO `_seq_user_id` (`sequence`) VALUES (4);
