export default {
  shared: {
    buttons: {
      cancel: 'Cancel',
      create: 'Create',
      delete: 'Delete',
      complete: 'Complete',
      search: 'Search',
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
    dashboard: {
      title: 'Hello {name}!',
    },
    drafts: {
      title: 'Drafts',
      instruction: 'Select draft from list or create a new one',
    },
    draft: {
      hiredAt: 'On Board Since',
    },
    employees: {
      title: 'Employees',
      nav: {
        list: 'List',
        search: 'Search',
        overview: 'Overview',
      }
    },
    employee: {
      instruction: 'Select evaluation from list to see details'
    },
    employeesSearch: {
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
    },
    evaluation: {
      hiredAt: 'Hired Date',
      completedAt: 'Completion Date',
    },
    template: {
      label: 'Template Name',
      placeholder: {
        name: 'Employee Name',
        position: 'Position',
        hiredAt: 'Hired Date',
        completedAt: 'Completion Date',
      }
    },
    templates: {
      title: 'Templates',
      instruction: 'Select template from list or create a new one',
    }
  }
}
