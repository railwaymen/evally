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
    next({ name: 'login_path' })
  }
}

export const adminAuthorizedGuard = (_to, from, next) => {
  const user = store.state.AuthenticationModule.user

  if (user.isAdmin) next()
  else {
    notifyUnauthorizedAction()
    next({ name: from.name || 'dashboard_path' })
  }
}

export const recruiterAuthorizedGuard = (_to, from, next) => {
  const user = store.state.AuthenticationModule.user

  if (user.isAdmin || user.isRecruiter) next()
  else {
    notifyUnauthorizedAction()
    next({ name: from.name || 'dashboard_path' })
  }
}
