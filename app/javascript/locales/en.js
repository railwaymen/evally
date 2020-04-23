export default {
  shared: {
    general:{
      fields: {
        firstName: 'First name',
        lastName: 'Last name',
        email: 'Email',
        phoneNumber: 'Phone number',
        source: 'Source',
        status: 'Status',
        group: 'Group',
        evaluator: 'Evaluator'
      }
    },
    buttons: {
      cancel: 'Cancel',
      create: 'Create',
      update: 'Update',
      delete: 'Delete',
      complete: 'Complete',
      search: 'Search',
      reset: 'Reset',
      save: 'Save',
      changePassword: 'Change Password',
      yes: 'Yes',
      no: 'No',
      archive: 'Archive',
    },
    tooltips: {
      edit: 'Edit',
      create: 'Create',
      addNew: 'Add New',
      addEvaluation: 'Add Evaluation',
      complete: 'Complete',
      save: 'Save',
      reset: 'Reset',
      delete: 'Delete',
      hideSidebar: 'Hide Sidebar',
      showSidebar: 'Show Sidebar',
      fullWidth: 'Full Width',
      halfWidth: 'Half Width',
      copyLink: 'Copy Link',
      close: 'Close',
      archive: 'Archive',
      openInfo: 'Open Information',
      sensitiveInfo: 'Sensitive Information'
    },
    navbar: {
      dashboard: 'Dashboard',
      evaluations: 'Evaluations',
      employees: 'Employees',
      recruitments: 'Recruitments',
      templates: 'Templates',
      settings: 'Settings',
      users: 'Users',
      logout: 'Logout',
    },
    validations: {
      required: 'This field is required',
      min6: 'Must have 6 or more characters',
      isString: 'Must be a string',
      confirmed: 'Both passwords must be the same'
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
    evaluations: {
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
        title: 'Delete Evaluation',
        body: 'Are you sure you want to delete this draft evaluation?'
      },
      completeForm: {
        title: 'Complete Evaluation',
        question: 'Are you sure you want to complete this evaluation?',
        warning: 'This action cannot be undo.',
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
      },
      staticSection: {
        yes: 'Yes',
        no: 'No',
      }
    },
    employees: {
      table: {
        search: 'Search ...',
        cols: {
          name: 'Name',
          hiredOn: 'Hired Date',
          group: 'Group',
          position: 'Position',
          positionSetOn: 'Promotion Date',
          evaluatorName: 'Evaluator Name',
          latestEvaluationAt: 'Latest Evaluation Date',
          archivedOn: 'Archived Date',
        }
      },
      deleteConfirm: {
        title: 'Delete Employee',
        body: 'Are you sure you want to delete this employee?'
      },
      archiveForm: {
        title: 'Archive Employee',
        body: 'Are you sure you want to archive this employee?',
        dateRequest: 'Please provide an archivization date: ',
        archivedOn: 'Archivization Date'
      },
      searchTable: {
        cols: {
          name: 'Name',
          skill: 'Skill',
          hiredOn: 'Hired Date',
          group: 'Group',
          position: 'Position',
          positionSetOn: 'Promotion Date',
          evaluatorName: 'Evaluator Name',
          latestEvaluationAt: 'Latest Evaluation Date',
        },
        labels: {
          yes: 'Yes',
          no: 'No',
        }
      },
      employeeForm: {
        createTitle: 'Create Employee',
        updateTitle: 'Update Employee',
        general: 'General',
        employment: 'Employment',
        evaluation: 'Evaluation',
        firstName: 'First Name',
        lastName: 'Last Name',
        position: 'Position',
        group: 'Group',
        hiredOn: 'Hired Date',
        positionSetOn: 'Promotion Date',
        nextEvaluationOn: 'Next Evaluation Date',
        evaluator: 'Evaluator'
      },
      sidebar: {
        group: 'Group',
        hiredOn: 'Hired Date',
        nextEvaluationOn: 'Next Evaluation Date',
        archivedOn: 'Archived Date',
        completedEvaluations: {
          title: 'Completed Evaluations',
          noContent: 'No evaluations yet'
        },
        positionChanges: {
          title: 'Position Changes',
          previous: 'Previous: {name}',
          noContent: 'No position changes yet',
        }
      },
      positionsChart: {
        title: 'Employees by Positions'
      },
      employeesPastYearChart: {
        title: 'Employees Changes By Months',
        hiredEmployees: 'Hired Employees',
        archivedEmployees: 'Archived Employees'
      },
      evaluationsPastYearChart: {
        title: 'Completed Evaluations By Months',
        completedEvaluations: 'Completed Evaluations'
      },
      employeesByUsersChart: {
        title: 'Employees By Users',
        employees: 'Employees'
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
      },
      passwordForm: {
        subtitle: 'Change Password',
        newPassword: 'New Password',
        passwordConfirmation: 'Password Confirmation',
        password: 'Current Password',
      }
    },
    templates: {
      sidebar: {
        search: 'Search ...',
        subheader: 'Available Templates',
        createdBy: 'created by {name}',
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
        sensitive: {
          title: 'Sensitive Content',
          yes: 'Yes',
          no: 'No'
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
    },
    users: {
      table: {
        search: 'Search ...',
        you: 'you',
        cols: {
          name: 'Name',
          email: 'Email',
          role: 'Role',
          latestActivity: 'Latest Activity',
          status: 'Status',
          invitationStatus: 'Invitation Status',
        }
      },
      userForm: {
        createTitle: 'Create User',
        updateTitle: 'Update User',
        email: 'Email',
        firstName: 'First Name',
        lastName: 'Last Name',
        role: 'Role',
        status: 'Status',
        group: 'Group'
      }
    },
    recruitments: {
      table: {
        search: 'Search ...',
        groupFilter: 'Group',
        statusFilter: 'Status',
        cols: {
          email: 'Email',
          group: 'Group',
          status: 'Status',
          position: 'Position',
          receivedAt: 'Received Date'
        },
      },
      recruitmentForm: {
        createTitle: 'New Recruit Document',
        updateTitle: 'Edit Recruit Document',
        contact: 'Contact',
        general: 'General',
        agreements: 'Agreements',
        addFiles: 'Add Files ...',
        male: 'male',
        female: 'female',
        position: 'Position',
        receivedDate: 'Received Date',
        acceptCurrentProcessing: 'Accept for current recruitment',
        acceptFutureProcessing: 'Accept for future recruitments',
        attachments: 'Attachments',
        socials: 'Socials'
      },
      deleteConfirm: {
        title: 'Delete Recruit Document',
        body: 'Are you sure you want to delete this recruit document?'
      },
      recruitmentFilePreview: {
        label: 'Select Attached File'
      },
      createEvaluationForm: {
        title: 'Add Evaluation',
        selectTemplate: 'Select Template',
        templateLabel: 'Template Name'
      },
      evaluationsSidebar: {
        selectLabel: 'Evaluation'
      },
      deleteAttachmentConfirm: {
        title: 'Delete Attachment',
        body: 'Are you sure you want to delete this attachment?'
      },
      deleteCommentConfirm: {
        title: 'Delete Comment',
        body: 'Are you sure you want to delete this comment?'
      },
      sidebar: {
        contactInformation: 'Contact Information',
        applicationDetails: 'Application Details',
        attachments: 'Attachments ({n})',
        gender: 'Gender',
        nationality: 'Nationality',
        email: 'Email',
        phoneNumber: 'Phone Number',
        status: 'Status',
        group: 'Group',
        position: 'Position',
        evaluator: 'Evaluator',
        source: 'Source',
        receivedDate: 'Received Date',
        addFile: 'Add File'
      },
      statusChangeForm: {
        title: 'Change Status'
      }
    }
  },
  messages: {
    comments: {
      create: {
        ok: 'Comment has been created',
        error: 'Comment cannot be created: {msg}'
      },
      update: {
        ok: 'Comment has been updated',
        error: 'Comment cannot be updated: {msg}'
      },
      delete: {
        ok: 'Comment has been deleted',
        error: 'Comment cannot be deleted: {msg}'
      }
    },
    evaluations: {
      index: {
        error: 'Evaluation drafts cannot be loaded: {msg}'
      },
      show: {
        error: 'Evaluation draft cannot be loaded: {msg}'
      },
      create: {
        ok: 'Evaluation draft has been created',
        error: 'Evaluation draft cannot be created: {msg}'
      },
      update: {
        ok: 'Evaluation draft has been updated',
        error: 'Evaluation draft cannot be updated: {msg}'
      },
      complete: {
        ok: 'Evaluation draft has been completed',
        error: 'Evaluation draft cannot be completed: {msg}'
      },
      delete: {
        ok: 'Evaluation draft has been deleted',
        error: 'Evaluation draft cannot be deleted: {msg}'
      }
    },
    employees: {
      index: {
        error: 'Employees cannot be loaded: {msg}'
      },
      archived: {
        error: 'Archived employees cannot be loaded: {msg}'
      },
      overview: {
        error: 'Data cannot be loaded: {msg}'
      },
      show: {
        error: 'Employee cannot be loaded: {msg}',
        copyLink: 'Employee\'s public link has been copied to clipboard'
      },
      showEvaluation: {
        error: 'Evaluation cannot be loaded: {msg}'
      },
      create: {
        ok: 'Employee has been created',
        error: 'Employee cannot be created: {msg}'
      },
      update: {
        ok: 'Employee has been updated',
        error: 'Employee cannot be updated: {msg}'
      },
      delete: {
        ok: 'Employee has been deleted',
        error: 'Employee cannot be deleted: {msg}'
      },
      archive: {
        ok: 'Employee has been archived',
        error: 'Employee cannot be archived: {msg}'
      },
    },
    session: {
      acceptInvitation: {
        ok: 'Your password has been saved, now you can sign in',
        error: 'Password cannot be setup: {msg}'
      },
      forgotPassword: {
        ok: 'Password reset instructions has been sent to you',
        error: 'Password cannot be reset: {msg}'
      },
      resetPassword: {
        ok: 'Your password has been saved, now you can sign in',
        error: 'Password cannot be saved: {msg}'
      },
      show: {
        error: 'User settings cannot be loaded: {msg}'
      },
      create: {
        ok: 'You have been logged in',
        error: 'Invalid credentials, please try again'
      },
      updateSetting: {
        ok: 'Settings have been updated',
        error: 'Settings cannot be updated: {msg}'
      },
      updateUser: {
        ok: 'Profile has been updated',
        error: 'Profile cannot be updated: {msg}'
      },
      updatePassword: {
        ok: 'Password has been updated, log in again to continue',
        error: 'Password cannot be updated: {msg}'
      },
      destroy: {
        ok: 'You have been logged out'
      }
    },
    templates: {
      index: {
        error: 'Templates cannot be loaded: {msg}'
      },
      show: {
        error: 'Template cannot be loaded: {msg}'
      },
      create: {
        ok: 'Template has been created',
        error: 'Template cannot be created: {msg}'
      },
      update: {
        ok: 'Template has been updated',
        error: 'Template cannot be updated: {msg}'
      },
      delete: {
        ok: 'Template has been deleted',
        error: 'Template cannot be deleted: {msg}'
      }
    },
    users: {
      index: {
        error: 'Users cannot be loaded: {msg}'
      },
      create: {
        ok: 'User has been created',
        error: 'User cannot be created: {msg}'
      },
      update: {
        ok: 'User has been updated',
        error: 'User cannot be updated: {msg}'
      }
    },
    recruitments: {
      index: {
        error: 'Recruit documents cannot be loaded: {msg}'
      },
      create: {
        ok: 'Recruit document has been created',
        error: 'Recruit document cannot be created: {msg}'
      },
      update: {
        ok: 'Recruit document has been updated',
        error: 'Recruit document cannot be updated: {msg}'
      },
      show: {
        error: 'Recruit document cannot be loaded: {msg}',
        positionError: 'Position cannot be blank',
        groupError: 'Group cannot be blank'
      },
      destroy: {
        ok: 'Recruit document has been deleted',
        error: 'Recruit document cannot be deleted: {msg}'
      },
      uploadAttachments: {
        ok: 'Attachments has been uploaded',
        error: 'Attachments cant be uploaded: {msg}'
      },
      destroyAttachment: {
        ok: 'Attachment has been deleted',
        error: 'Attachment cannot be deleted: {msg}'
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
    },
    user: {
      roles: {
        admin: 'Admin',
        recruiter: 'Recruiter',
        evaluator: 'Evaluator'
      },
      statuses: {
        active: 'Active',
        inactive: 'Inactive'
      },
      invitationStatuses: {
        pending: 'Pending',
        accepted: 'Accepted'
      }
    }
  },
  views: {
    browser: {
      show: {
        instruction: 'Please enter your last name to see your evaluations: '
      }
    },
    dashboards: {
      show: {
        title: 'Hello {name}!',
      }
    },
    evaluations: {
      index: {
        title: 'Evaluations',
        instruction: 'Select draft from list or create a new one',
      },
      show: {
        hiredOn: 'Hired Date',
      }
    },
    employees: {
      index: {
        title: 'Employees',
        nav: {
          list: 'List',
          search: 'Search',
          overview: 'Overview',
          archived: 'Archived',
        },
      },
      show: {
        instruction: 'Select evaluation from list to see details'
      },
      evaluation: {
        hiredOn: 'Hired Date',
        completedAt: 'Completion Date',
      },
      overview: {
        employment: 'Employment',
        evaluations: 'Evaluations',
        tiles: {
          averageEmployment: 'Average Employment',
          employees: 'Employees',
          changesThisYear: 'Changes In {year}',
          months: 'month | months',
          years: 'year | years',
          hired: 'Hired',
          archived: 'Archived',
          new: 'New',
          averageEvaluations: 'Average Evaluations',
          evaluationsPerEmployee: 'Per Employee',
          allEvaluations: 'All Evaluations',
          evaluationsThisYear: 'Evaluations In {year}',
          completed: 'Completed'
        }
      },
      search: {
        label: 'Skill',
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
        logOutWarning: 'You will be logged out after successful password change.',
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
        name: 'Template Name',
        destination: 'Destination',
        placeholder: {
          name: 'Employee Name',
          position: 'Position',
          hiredOn: 'Hired Date',
          completedAt: 'Completion Date',
        }
      }
    },
    recruitments: {
      index: {
        title: 'Recruitments',
        nav: {
          list: 'List'
        }
      },
      show: {
        title: 'Recruitment'
      }
    }
  }
}
