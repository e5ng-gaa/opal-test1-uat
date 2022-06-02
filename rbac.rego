# Role-based Access Control (RBAC)
# --------------------------------

#Название пакета, который используется
package app.rbac

# test suhovdg
# import data.utils

# По умолчанию запретить любые действия
default allow = false

# Разрешить админам любые действия
allow {
	user_is_admin
}

# Разрешить действие если у пользователя есть разрешение
allow {
	# Найти разрешения для пользователя.
	some permission
	user_is_granted[permission]

	# Проверить, есть ли разрешение.
	input.action == permission.action
	input.target == permission.target
}

# пользователь является админом, если...
user_is_admin {
	# для некоторых `i`...
	some i

	# "admin" - `i`-тый элемент в user->role мэппинге для зарегистрированного пользователя.
	data.users[input.user].roles[i] == "admin"
}

# user_is_granted - набор разрешений для юзера определенного в запросе.
# `permission` will be contained if the set `user_is_granted` для каждого...
user_is_granted[permission] {
	some i, j

	# `role` assigned an element of the user_roles for this user...
	role := data.users[input.user].roles[i]

	# `permission` assigned a single permission from the permissions list for 'role'...
	permission := data.role_permissions[role][j]
}







