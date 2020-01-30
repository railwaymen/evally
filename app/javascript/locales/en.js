export default {
  shared: {
    buttons: {
      cancel: 'Cancel',
      create: 'Create'
    },
    tooltips: {
      edit: 'Edit',
      create: 'Create'
    },
    navbar: {
      dashboard: 'Dashboard',
      drafts: 'Drafts',
      employees: 'Employees',
      templates: 'Templates',
      settings: 'Settings',
      logout: 'Logout'
    }
  },
  components: {
    dashboard: {
      activitiesFeed: {
        title: 'Latest Activities',
        noContent: 'There are no activities yet'
      },
      drafts: {
        title: 'Drafts',
        noContent: 'There are no drafts to show',
        as: 'as',
        updated: 'Updated {date}'
      },
      upcoming: {
        title: 'Upcoming',
        as: 'as',

      }
    }
  },
  models: {
    employee: {
      justStarted: 'just started',
      firstTime: 'First time',
      works: 'works',
      month: '{n} month | {n} months',
      year: '{n} year | {n} years',
      and: 'and'
    }
  },
  views: {
    dashboard: {
      title: 'Hello {name}!',
    }
  }
}
