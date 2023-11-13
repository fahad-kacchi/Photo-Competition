select full_name, theme_description, photo
from login, photo_register, winner, theme
where login.login_id = photo_register.login_id and
theme.theme_id = photo_register.theme_id and
winner.theme_id = theme.theme_id and
winner.login_id = login.login_id and
current_theme_flag != 1;

select * from photo_register
where theme_id = 'T1';