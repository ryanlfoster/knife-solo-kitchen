SELECT USER() RequestedUserLogin,CURRENT_USER() AllowedUserLogin;

INSERT INTO `wp_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES (NULL, 'devadmin', MD5('pass'), 'nicename', 'email', 'url', '2010-10-08 00:00:00', '', '0', 'displayname');

SET @newID = (Select ID from wp_users where user_login='devadmin'); 

INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, @newID, 'wp_capabilities', 'a:1:{s:13:"administrator";b:1;}');
INSERT INTO `wp_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`) VALUES (NULL, @newID, 'wp_user_level', '10');

