import store from '@store/store'

export const authenticationGuard = (_to, _from, next) => {
  if (localStorage.getItem('ev411y_t0k3n')) next()
  else {
    store.commit(
      'NotificationsModule/push',
      { error: 'You are not authoenticated. Please log in.' }
    )

    next({ name: 'login_path' })
  }
}

export const authorizationGuard = (_to, from, next) => {
  const user = store.getters['SessionModule/user']

  if (user.isAdmin) next()
  else {
    store.commit(
      'NotificationsModule/push',
      { error: 'You have not permissions to see that content.' }
    )

    next({ name: from.name })
  }
}
