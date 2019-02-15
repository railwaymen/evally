export default {
  buttons: {
    archive: 'Archive',
    cancel: 'Cancel',
    change_pass: 'Change password',
    complete: 'Complete',
    copy: 'Copy',
    create: 'Create',
    delete: 'Delete',
    edit: 'Edit',
    filter: 'Filter',
    hide: 'Hide',
    reset: 'Reset',
    save: 'Save',
    show: 'Show'
  },
  destroy_modals: {
    default: {
      title: 'Delete',
      confirm: 'Are you sure you want to delete it?'
    },
    evaluation: {
      title: 'Delete evaluation',
      confirm: 'Are you sure you want to delete this evaluation?'
    },
    employee: {
      title: 'Delete employee',
      confirm: 'Are you sure you want to delete this employee?'
    },
    template: {
      title: 'Delete template',
      confirm: 'Are you sure you want to delete this template?'
    }
  },
  archive: {
    title: 'Archive',
    sidebar: {
      search: 'Search ...',
      subheader: 'All employees & evaluations',
      evaluations_subheader: 'List of evaluations ({count})',
      no_items: 'There are no employees',
      tabs: {
        employees: 'Employees',
        activities: 'Activities'
      },
      filter_title: 'Filter by date',
      date_from: 'From',
      date_to: 'To'
    },
    messages: {
      no_activities: 'There are no activities to show.'
    },
    flashes: {
      fetch: {
        error: 'Activities cannot be loaded due to some error: {reason}'
      }
    }
  },
  employees: {
    title: 'Employees',
    buttons: {
      add_new: 'New employee',
      permalink: 'Permalink',
      edit: 'Edit employee',
      archive: 'Archive employee',
      delete: 'Delete employee'
    },
    flashes: {
      archive: {
        success: 'Employee has been succefully archived.',
        error: 'Employee cannot be archived due to some error: {reason}'
      },
      create: {
        success: 'Employee has been succefully created.',
        error: 'Employee cannot be created due to some error: {reason}'
      },
      edit: {
        success: 'Employee has been succefully updated.',
        error: 'Employee cannot be updated due to some error: {reason}'
      },
      fetch: {
        error: 'Employees cannot be loaded due to some error: {reason}'
      },
      delete: {
        success: 'Employee has been succefully deleted.',
        error: 'Employee cannot be destroyed due to some error: {reason}'
      },
      permalink: {
        success: 'Permalink has been copied to clipboard.'
      }
    },
    forms: {
      archive: {
        title: 'Archive employee',
        warning: 'This action cannot be undo. All drafted evaluations of the employee will be destroyed!',
        text: 'Please, provide the reason to archive the employee: ',
        too_experienced: 'Too experienced',
        released: 'Released',
        released_at: 'Released at'
      },
      permalink: {
        title: 'Share permalink',
        text: 'Copy the permalink below to share the latest evaluation:'
      },
      create_title: 'Create employee',
      edit_title: 'Edit employee',
      first_name: 'First name',
      last_name: 'Last name',
      position: 'Position',
      group: 'Group',
      hired_at: 'On board since',
      next_review: 'Next review',
      cooperation: 'Cooperation',
      since: 'since',
      to: 'to'
    },
    messages: {
      select: 'Select employee to see his latest evaluation.',
      not_evaluated: '{name} has not been evaluated yet.'
    },
    sidebar: {
      search: 'Search ...',
      subheader: 'List of employees',
      no_items: 'There are no employees'
    }
  },
  evaluations: {
    title: 'Evaluations',
    buttons: {
      add_new: 'New evaluation',
      complete: 'Complete evaluation',
      save_draft: 'Save draft',
      reset: 'Undo changes',
      delete: 'Delete evaluation'
    },
    flashes: {
      create: {
        success: 'Evaluation has been succefully created.',
        error: 'Evaluation cannot be created due to some error: {reason}'
      },
      fetch: {
        error: 'Evaluations cannot be loaded due to some error: {reason}'
      },
      save: {
        success: 'Evaluation has been succefully updated.',
        error: 'Evaluation cannot be updated due to some error: {reason}'
      },
      complete: {
        success: 'Evaluation has been succefully completed.',
        error: 'Evaluation cannot be completed due to some error: {reason}'
      },
      delete: {
        success: 'Evaluation has been succefully deleted.',
        error: 'Evaluation cannot be destroyed due to some error: {reason}'
      }
    },
    forms: {
      complete: {
        title: 'Complete evaluation',
        question: 'Are you sure you want to complete this evaluation?',
        warning: 'This action cannot be undo.',
        next_label: 'Next evaluation at'
      },
      create_title: 'Create draft',
      select_employee: 'Select employee',
      select_template: 'Select template',
      employee_label: 'Employee',
      template_label: 'Template',
      bool_no: 'No',
      bool_yes: 'Yes',
      hired_at: 'hired at',
      next_review: 'next review',
      completed_at: 'completed at'
    },
    message: 'Select draft evaluation or create a new one.',
    sidebar: {
      search: 'Search ...',
      subheader: 'Evaluations drafts',
      subtitle: 'based on \'{name}\' template',
      no_items: 'There are no evaluations drafts'
    }
  },
  settings: {
    title: 'Settings',
    sidebar: {
      general: 'General',
      evaluations: 'Evaluations',
      profile: 'Profile',
      support: 'Support'
    },
    flashes: {
      save_setting: {
        success: 'Settings have been succefully saved.',
        error: 'Settings cannot be saved due to some error: {reason}'
      },
      update_user: {
        success: 'User profile has been succefully saved.',
        error: 'User profile cannot be saved due to some error: {reason}'
      },
      update_pass: {
        success: 'Passowrd has been succefully changed.',
        error: 'Password cannot be changed due to some error: {reason}'
      }
    },
    general: {
      title: 'General settings',
      language: {
        subheader: 'Language',
        polish: 'Polish',
        english: 'English'
      },
      widgets: {
        subheader: 'Dashboard widgets',
        draft_items: 'Number of draft items',
        upcoming_items: 'Number of upcoming items'
      }
    },
    evaluations: {
      title: 'Evaluations settings',
      defaults: {
        subheader: 'Default options',
        next_review_offset: 'Months to next review [months]'
      }
    },
    profile: {
      title: 'Profile settings',
      basic: {
        subheader: 'Basic profile information',
        email: 'Email',
        first_name: 'First name',
        last_name: 'Last name'
      },
      password: {
        subheader: 'Change password',
        warning: 'You will be logged out after successful password change.',
        new_pass: 'New password',
        old_pass: 'Old password',
        confirm_pass: 'Password confirmation'
      }
    },
    support: {
      title: 'Support',
      text: 'Soon ...'
    }
  },
  templates: {
    title: 'Templates',
    buttons: {
      add_new: 'New template',
      edit: 'Edit template',
      save: 'Save template',
      delete: 'Delete evaluation'
    },
    flashes: {
      create: {
        success: 'Template has been succefully created.',
        error: 'Template cannot be created due to some error: {reason}'
      },
      fetch: {
        error: 'Templates cannot be loaded due to some error: {reason}'
      },
      save: {
        success: 'Template has been succefully updated.',
        error: 'Template cannot be updated due to some error: {reason}'
      },
      delete: {
        success: 'Template has been succefully deleted.',
        error: 'Template cannot be destroyed due to some error: {reason}'
      }
    },
    forms: {
      template_name: 'Template name',
      section_title: 'Section title',
      buttons: {
        full_width: 'Full width',
        half_width: 'Half width',
        delete: 'Delete section'
      },
      inputs: {
        text: 'New text item',
        rating: 'New rating item',
        bool: 'New boolean item'
      },
      new_section: {
        title: 'New section',
        width: {
          subheader: 'Width: ',
          full: 'Full',
          half: 'Half'
        },
        type: {
          subheader: 'Type: ',
          rating: 'Rating',
          boolean: 'Yes/No',
          text: 'Text'
        },
        button: 'Add section'
      }
    },
    messages: {
      select: 'Select a template or create a new one.',
    },
    placeholders: {
      name: 'employee name',
      position: 'employee position'
    },
    sidebar: {
      search: 'Search ...',
      subheader: 'All templates',
      no_items: 'There are no templates'
    }
  },
  dashboard: {
    title: 'Hello {name}!',
    common: {
      as: ' as ',
      first_time: 'First time'
    },
    drafts: {
      title: 'Drafts',
      edit_tooltip: 'Edit',
      updated: 'Updated {date}'
    },
    upcoming: {
      title: 'Upcoming',
      new_tooltip: 'Create'
    },
    activities: {
      title: 'Activities',
      no_activities: 'There are no activities today',
      see_more: 'See more'
    }
  },
  widgets: {
    employment: {
      title: 'Employment time',
      no_data_info: 'You have not enough employees to present this data.',
      average: 'average',
      buttons: {
        shortest: 'shortest',
        longest: 'longest'
      },
      list_items: {
        as: 'as',
        works: 'works',
        day: 'day',
        days: 'days',
        and: 'and',
        year: 'year',
        years: 'years'
      },
      view_profile: 'View profile'
    }
  },
  navbar: {
    dashboard: 'Dashboard',
    evaluations: 'Evaluations',
    employees: 'Employees',
    templates: 'Templates',
    archive: 'Archive',
    overview: 'Overview',
    settings: 'Settings',
    logout: 'Logout'
  },
  validation: {
    required: 'This field is required.',
    min6: 'Must have 6 or more characters.',
    isString: 'Must be a string.',
    confirmed: 'Both passwords must be the same.'
  }
}