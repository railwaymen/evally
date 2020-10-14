import store from '@store/store'

const notifyUnauthorizedAction = () => {
  store.commit(
    'MessagesModule/PUSH_MESSAGE',
    { error: 'You are unauthorized to perform this action.' }
  )
}

// Guards

export const alreadyAuthenticatedGuard = (_to, _from, next) => {
  localStorage.getItem('ev411y_t0k3n') ? next({ name: 'dashboard_path' }) : next()
}

export const authenticationGuard = (_to, _from, next) => {
  if (localStorage.getItem('ev411y_t0k3n')) next()
  else {
    notifyUnauthorizedAction()
    localStorage.setItem('ev411y_r3d1r3ct', window.location.pathname)

    next({ name: 'login_path' })
  }
}

export const adminAuthorizedGuard = (_to, from, next) => {
  const storedUser = store.state.AuthenticationModule.user

  if (storedUser.isAdmin) next()
  else {
    store.watch(
      state => state.AuthenticationModule.user,
      watchedUser => {
        if (watchedUser.isAdmin) next()
        else {
          notifyUnauthorizedAction()
          next({ name: from.name || 'dashboard_path' })
        }
      }
    )

    next()
  }
}

export const recruiterAuthorizedGuard = (_to, from, next) => {
  const storedUser = store.state.AuthenticationModule.user

  if (storedUser.isAdmin || storedUser.isRecruiter) next()
  else {
    store.watch(
      state => state.AuthenticationModule.user,
      watchedUser => {
        if (watchedUser.isAdmin || watchedUser.isRecruiter) next()
        else {
          notifyUnauthorizedAction()
          next({ name: from.name || 'dashboard_path' })
        }
      }
    )

    next()
  }
}
