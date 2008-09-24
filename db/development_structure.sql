CREATE TABLE `buses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `capacity` int(11) default NULL,
  `info` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `campers` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `fname` varchar(255) default NULL,
  `lname` varchar(255) default NULL,
  `mname` varchar(255) default NULL,
  `pref_name` varchar(255) default NULL,
  `dob` date default NULL,
  `gender` int(11) default NULL,
  `address` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` int(11) default NULL,
  `roomate_choice` varchar(255) default NULL,
  `parent_lname` varchar(255) default NULL,
  `parent_fname` varchar(255) default NULL,
  `phone1` varchar(255) default NULL,
  `phone2` varchar(255) default NULL,
  `emergency_name` varchar(255) default NULL,
  `emergency_phone` varchar(255) default NULL,
  `school` varchar(255) default NULL,
  `teacher` varchar(255) default NULL,
  `grade` int(11) default NULL,
  `shirt_size` int(11) default NULL,
  `number` varchar(255) default NULL,
  `position` int(11) default NULL,
  `health_concerns` text,
  `bus_id` int(11) default NULL,
  `inactive` tinyint(1) default NULL,
  `inactive_info` text,
  `email` varchar(255) default NULL,
  `race` varchar(255) default NULL,
  `last_tetnus_shot` date default NULL,
  `code_of_conduct` tinyint(1) default NULL,
  `media_release` int(11) default NULL,
  `equine_release` tinyint(1) default NULL,
  `rec_zone` int(11) default NULL,
  `payment_number` varchar(255) default NULL,
  `reference` tinyint(1) default NULL,
  `physician_insurance_info` tinyint(1) default NULL,
  `emergency_info` tinyint(1) default NULL,
  `immunizations_current` tinyint(1) default NULL,
  `release_authorization` tinyint(1) default NULL,
  `parental_signatures` tinyint(1) default NULL,
  `pool_spotting` int(11) default NULL,
  `room_number` varchar(255) default NULL,
  `counselor_years` int(11) default NULL,
  `pack_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `course_selections` (
  `id` int(11) NOT NULL auto_increment,
  `camper_id` int(11) default NULL,
  `course_id` int(11) default NULL,
  `preference` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `courses` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `packs` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `receipts` (
  `id` int(11) NOT NULL auto_increment,
  `date` datetime default NULL,
  `fname` varchar(255) default NULL,
  `lname` varchar(255) default NULL,
  `address` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `zip` int(11) default NULL,
  `city` varchar(255) default NULL,
  `amount` float default NULL,
  `payment_method` int(11) default NULL,
  `payment_extra` varchar(255) default NULL,
  `camper1` varchar(255) default NULL,
  `camper1_id` varchar(255) default NULL,
  `camper2` varchar(255) default NULL,
  `camper2_id` varchar(255) default NULL,
  `camper3` varchar(255) default NULL,
  `camper3_id` varchar(255) default NULL,
  `account_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `phone` varchar(255) default NULL,
  `refund` tinyint(1) default NULL,
  `refund_date` datetime default NULL,
  `refund_check_number` int(11) default NULL,
  `refund_amount` float default NULL,
  `refund_info` text,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE `states` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `lname` varchar(255) default NULL,
  `fname` varchar(255) default NULL,
  `content_type` varchar(255) default 'image/png',
  `picture` longblob,
  `title` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

INSERT INTO schema_info (version) VALUES (33)