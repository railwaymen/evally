export default {
  shared: {
    buttons: {
      cancel: 'Cancel',
      create: 'Create',
      delete: 'Delete',
      complete: 'Complete',
      search: 'Search',
      reset: 'Reset',
      save: 'Save',
      changePassword: 'Change Password'
    },
    tooltips: {
      edit: 'Edit',
      create: 'Create',
      addNew: 'Add New',
      complete: 'Complete',
      save: 'Save',
      reset: 'Reset',
      delete: 'Delete',
      hideSidebar: 'Hide Sidebar',
      showSidebar: 'Show Sidebar',
      fullWidth: 'Full Width',
      halfWidth: 'Half Width',
    },
    navbar: {
      dashboard: 'Dashboard',
      drafts: 'Drafts',
      employees: 'Employees',
      templates: 'Templates',
      settings: 'Settings',
      logout: 'Logout',
    },
    validations: {
      required: 'This field is required.',
      min6: 'Must have 6 or more characters.',
      isString: 'Must be a string.',
      confirmed: 'Both passwords must be the same.'
    }
  },
  components: {
    dashboard: {
      activitiesFeed: {
        title: 'Latest Activities',
        noContent: 'There are no activities yet',
      },
      drafts: {
        title: 'Drafts',
        noContent: 'There are no drafts to show',
        as: 'as',
        updated: 'Updated {date}',
      },
      upcoming: {
        title: 'Upcoming',
        as: 'as',

      }
    },
    drafts: {
      sidebar: {
        search: 'Search ...',
        subheader: 'Evaluations In Progress',
        subtitle: 'based on \'{name}\' template',
        noContent: 'There are no drafts to show'
      },
      section: {
        yes: 'Yes',
        no: 'No',
      },
      deleteConfirm: {
        title: 'Delete Draft',
        body: 'Are you sure you want to delete this draft?'
      },
      completeForm: {
        title: 'Complete Evaluation',
        question: 'Are you sure you want to complete this evaluation?',
        warning: 'This action cannot be undo',
        nextEvaluation: 'Next Evaluation',
      },
      createForm: {
        title: 'Create Draft',
        selectEmployee: 'Select Employee',
        employeeLabel: 'Employee',
        selectTemplate: 'Select Template',
        templateLabel: 'Template',
        latestTemplate: 'Latest template',
        newTemplate: 'New template',
      }
    },
    employees: {
      table: {
        search: 'Search ...',
        cols: {
          name: 'Name',
          hiredAt: 'Hired Date',
          group: 'Group',
          position: 'Position',
          positionSetAt: 'Promotion Date',
          latestEvaluationAt: 'Latest Evaluation Date',
        }
      },
      createForm: {
        title: 'Create Employee',
        general: 'General Information',
        dates: 'Dates',
        firstName: 'First Name',
        lastName: 'Last Name',
        position: 'Position',
        group: 'Group',
        hiredAt: 'Hired Date',
        positionSetAt: 'Promotion Date',
        nextEvaluationAt: 'Next Evaluation Date'
      },
      sidebar: {
        group: 'Group',
        hiredAt: 'Hired Date',
        nextEvaluationAt: 'Next Evaluation Date',
        completedEvaluations: {
          title: 'Completed Evaluations',
          noContent: 'No evaluations yet'
        },
        positionChanges: {
          title: 'Position Changes',
          previous: 'Previous: {name}',
          noContent: 'No position changes yet',
        }
      }
    },
    evaluations: {
      staticSection: {
        yes: 'Yes',
        no: 'No',
      }
    },
    settings: {
      sidebarNav: {
        general: 'General',
        profile: 'Profile',
        support: 'Support',
      },
      generalForm: {
        language: {
          subtitle: 'Langugage',
          english: 'English',
          polish: 'Polish',
        },
        widgets: {
          subtitle: 'Dashboard Widgets',
          drafts: 'Number of Draft Items',
          upcoming: 'Number of Upcoming Items'
        },
        evaluations: {
          subtitle: 'Evaluations',
          nextEvaluationOffset: 'Months to next evaluation'
        }
      },
      userForm: {
        subtitle: 'Basic Profile Information',
        email: 'Email',
        firstName: 'First Name',
        lastName: 'Last Name',
      }
    },
    templates: {
      sidebar: {
        search: 'Search ...',
        subheader: 'Available Templates',
        noContent: 'There are no templates to show'
      },
      deleteConfirm: {
        title: 'Delete Template',
        body: 'Are you sure you want to delete this template?'
      },
      sectionForm: {
        title: 'New Section',
        width: {
          title: 'Width',
          full: 'Full',
          half: 'Half',
        },
        group: {
          title: 'Type',
          rating: 'Rating',
          bool: 'Yes/No',
          text: 'Text',
        },
        button: 'Add Section'
      },
      sectionItemsList: {
        label: {
          rating: 'New Rating Item',
          bool: 'New Bool Item',
          text: 'New Text Item',
        }
      },
      sectionComposer: {
        title: 'Section Title'
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
      and: 'and',
    }
  },
  views: {
    dashboards: {
      show: {
        title: 'Hello {name}!',
      }
    },
    drafts: {
      index: {
        title: 'Drafts',
        instruction: 'Select draft from list or create a new one',
      },
      show: {
        hiredAt: 'On Board Since',
      }
    },
    employees: {
      index: {
        title: 'Employees',
        nav: {
          list: 'List',
          search: 'Search',
          overview: 'Overview',
        }
      },
      show: {
        instruction: 'Select evaluation from list to see details'
      },
      evaluation: {
        hiredAt: 'Hired Date',
        completedAt: 'Completion Date',
      },
      search: {
        label: 'Skill Name',
        table: {
          cols: {
            name: 'Name',
            skill: 'Skill',
            hiredAt: 'Hired Date',
            group: 'Group',
            position: 'Position',
            positionSetAt: 'Promotion Date',
            latestEvaluationAt: 'Latest Evaluation Date',
          }
        }
      }
    },
    settings: {
      show: {
        title: 'Settings',
      },
      general: {
        title: 'General Settings',
      },
      profile: {
        title: 'Profile Settings',
        password: {
          subtitle: 'Change Password',
          newPassword: 'New Password',
          confirmPassword: 'Password Confirmation',
          oldPassword: 'Old Password',
          warning: 'You will be logged out after successful password change.',
        }
      },
      support: {
        title: 'Support',
        text: 'Soon...'
      }
    },
    templates: {
      index: {
        title: 'Templates',
        instruction: 'Select template from list or create a new one',
      },
      show: {
        label: 'Template Name',
        placeholder: {
          name: 'Employee Name',
          position: 'Position',
          hiredAt: 'Hired Date',
          completedAt: 'Completion Date',
        }
      }
    }
  }
}
