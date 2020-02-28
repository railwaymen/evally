import store from '@store/store'

export const authenticationGuard = (_to, _from, next) => {
  if (localStorage.getItem('ev411y_t0k3n')) next()
  else {
    store.commit(
      'NotificationsModule/push',
      { error: 'You are not authenticated. Please log in.' }
    )

    next({ name: 'login_path' })
  }
}

export const authorizationGuard = (_to, from, next) => {
  const user = store.getters['AuthenticationModule/user']

  user.isAdmin ? next() : next({ name: from.name })
}
