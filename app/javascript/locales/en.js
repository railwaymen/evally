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
        evaluator: 'Evaluator',
        salary: 'Salary',
        contractType: 'Contract Type',
        availability: 'Availability',
        availableSince: 'Available Since',
        location: 'Location',
        workType: 'Work Type',
        message: 'Message',
        emailTemplate: 'Email Template',
        from: 'From',
        to: 'To',
        cc: 'CC',
        bcc: 'BCC',
        subject: 'Subject',
        name: 'Name',
        description: 'Description',
        participants: 'Participants',
        recruitment: 'Recruitment',
        stage: 'Stage'
      }
    },
    buttons: {
      cancel: 'Cancel',
      create: 'Create',
      update: 'Update',
      delete: 'Delete',
      start: 'Start',
      complete: 'Complete',
      search: 'Search',
      reset: 'Reset',
      save: 'Save',
      changePassword: 'Change Password',
      yes: 'Yes',
      no: 'No',
      archive: 'Archive',
      restore: 'Restore',
      send: 'Send',
      edit: 'Edit',
      preview: 'Preview',
      cc: 'CC',
      bcc: 'BCC',
      assign: 'Assign'
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
      restore: 'Restore',
      openInfo: 'Open Information',
      sensitiveInfo: 'Sensitive Information',
      acceptCurrentProcessing: 'Accept Current Processing',
      acceptFutureProcessing: 'Accept Future Processing',
      sendEmail: 'Send Email',
      backToProfile: 'Back To Profile',
      newRecruitment: 'New Recruitment',
      newAssignment: 'New Assignment'
    },
    navbar: {
      dashboard: 'Dashboard',
      evaluations: 'Evaluations',
      employees: 'Employees',
      candidates: 'Candidates',
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
        groupFilter: 'Group',
        evaluatorFilter: 'Evaluator',
        cols: {
          name: 'Name',
          hiredOn: 'Hired Date',
          group: 'Group',
          position: 'Position',
          positionSetOn: 'Promotion Date',
          currentEvaluator: 'Current Evaluator',
          lastEvaluationOn: 'Last Evaluation Date',
          archivedOn: 'Archived Date',
          nextEvaluationOn: 'Next Evaluation Date',
          signature: 'Signature'
        }
      },
      deleteConfirm: {
        title: 'Delete Employee',
        body: 'Are you sure you want to delete this employee?'
      },
      archiveForm: {
        title: 'Archive Employee',
        body: 'Are you sure you want to archive <strong>%{name}</strong>?',
        dateRequest: 'Please provide an archivization date: ',
        archivedOn: 'Archivization Date'
      },
      restoreConfirm: {
        title: 'Restore Employee',
        body: 'Are you sure you want to restore <strong>%{name}</strong>?'
      },
      searchTable: {
        cols: {
          name: 'Name',
          skill: 'Skill',
          hiredOn: 'Hired Date',
          group: 'Group',
          position: 'Position',
          positionSetOn: 'Promotion Date',
          currentEvaluator: 'Current Evaluator',
          lastEvaluationOn: 'Last Evaluation Date',
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
        lastEvaluationOn: 'Last Evaluation Date',
        nextEvaluationOn: 'Next Evaluation Date',
        evaluator: 'Evaluator',
        signature: 'Signature'
      },
      sidebar: {
        employment: 'Employment',
        evaluation: 'Evaluation',
        group: 'Group',
        hiredOn: 'Hired Date',
        signature: 'Signature',
        lastEvaluationOn: 'Last Evaluation Date',
        nextEvaluationOn: 'Next Evaluation Date',
        archivedOn: 'Archived Date',
        completedEvaluations: {
          title: 'Completed Evaluations',
          noContent: 'No evaluations yet'
        },
        positionChanges: {
          title: 'Position Changes',
          previous: 'Prev: {name}',
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
    layout: {
      notificationsMenu: {
        title: 'Notifications',
        noNotifications: 'There is no notifications yet',
        readAll: 'Read All',
        seeMore: 'See More'
      }
    },
    settings: {
      sidebarNav: {
        general: 'General',
        notifications: 'Notifications',
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
      notificationsForm: {
        enableUpcomingNotifications: 'Notify me about upcoming evaluations (every 1st of month)'
      },
      userForm: {
        basicInfo: 'Basic Profile Information',
        email: 'Email',
        firstName: 'First Name',
        lastName: 'Last Name',
        signature: 'Signature'
      },
      passwordForm: {
        subtitle: 'Change Password',
        newPassword: 'New Password',
        passwordConfirmation: 'Password Confirmation',
        password: 'Current Password',
      }
    },
    shared: {
      searchBySkillForm: {
        label: 'Skill'
      }
    },
    emailTemplates: {
      sidebar: {
        search: 'Search ...',
        subheader: 'Available Email Templates',
        createdBy: 'created by {name}',
        noContent: 'There are no email templates to show'
      },
      deleteConfirm: {
        title: 'Delete Email Template',
        body: 'Are you sure you want to delete this email template?'
      },
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
        evaluatorFilter: 'Evaluator',
        cols: {
          email: 'Email',
          group: 'Group',
          status: 'Status',
          position: 'Position',
          currentEvaluator: 'Current Evaluator',
          source: 'Source',
          receivedAt: 'Received Date',
          subject: 'Subject',
          parsed: 'Parsed',
          acceptCurrentProcessing: 'CP',
          acceptFutureProcessing: 'FP'
        },
      },
      searchTable: {
        labels: {
          yes: 'Yes',
          no: 'No'
        },
        cols: {
          name: 'Name',
          skill: 'Skill',
          group: 'Group',
          position: 'Position',
          source: 'Source',
          receivedDate: 'Received Date',
          status: 'Status',
          evaluationDate: 'Evaluation Date',
          evaluatorName: 'Evaluator Name',
          acceptCurrentProcessing: 'CP',
          acceptFutureProcessing: 'FP'
        }
      },
      assignmentForm: {
        title: 'Recruitment Assignment'
      },
      recruitmentForm: {
        createTitle: 'New Recruitment',
        updateTitle: 'Edit Recruitment',
      },
      recruitmentStatusConfirm: {
        startTitle: 'Start Recruitment',
        completeTitle: 'Complete Recruitment',
        startBody: 'Are you sure you want to start the recruitment <strong>%{name}</strong>?',
        completeBody: 'Are you sure you want to complete the recruitment <strong>%{name}</strong>?',
      },
      recruitDocumentForm: {
        createTitle: 'New Recruit Document',
        updateTitle: 'Edit Recruit Document',
        contact: 'Contact',
        general: 'General',
        applicationDetails: 'Application Details',
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
        body: 'Are you sure you want to delete the recruit <strong>%{name}</strong>?'
      },
      deleteRecruitmentConfirm: {
        title: 'Delete Recruitment',
        body: 'Are you sure you want to delete the recruitment <strong>%{name}</strong>?'
      },
      deleteRecruitmentCandidateConfirm: {
        title: 'Remove Candidate',
        body: 'Are you sure you want to remove <strong>%{name}</strong> from the recruitment <strong>%{recruitmentName}</strong>?'
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
        cp: 'CP',
        fp: 'FP',
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
        salary: 'Salary',
        contractType: 'Contract Type',
        availability: 'Availability',
        availableSince: 'Available Since',
        location: 'Location',
        workType: 'Work Type',
        message: 'Message',
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
      restore: {
        ok: 'Employee has been restored',
        error: 'Employee cannot be restored: {msg}'
      }
    },
    session: {
      acceptInvitation: {
        ok: 'Your password has been saved, now you can sign in',
        error: 'Password cannot be setup: {msg}'
      },
      forgotPassword: {
        ok: 'If an account exists, we will send you an instruction to reset the password'
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
    emails: {
      form: {
        error: 'Email form data cannot be loaded: {msg}'
      },
      send: {
        ok: 'Email has been send to {recipient}',
        error: 'Email cannot be sent: {msg}'
      }
    },
    emailTemplates: {
      index: {
        error: 'Email templates cannot be loaded: {msg}'
      },
      show: {
        error: 'Email template cannot be loaded: {msg}'
      },
      create: {
        ok: 'Email template has been created',
        error: 'Email template cannot be created: {msg}'
      },
      update: {
        ok: 'Email template has been updated',
        error: 'Email template cannot be updated: {msg}'
      },
      delete: {
        ok: 'Email template has been deleted',
        error: 'Email template cannot be deleted: {msg}'
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
        error: 'Recruitments cannot be loaded: {msg}'
      },
      create: {
        ok: 'Recruitment has been created',
        error: 'Recruitment cannot be created: {msg}'
      },
      start: {
        ok: 'Recruitment has been started',
        error: 'Recruitment cannot be started: {msg}'
      },
      complete: {
        ok: 'Recruitment has been completed',
        error: 'Recruitment cannot be completed: {msg}'
      },
      update: {
        ok: 'Recruitment has been updated',
        error: 'Recruitment cannot be updated: {msg}'
      },
      addStage: {
        ok: 'Recruitment stage has been added',
        error: 'Recruitment stage cannot be added: {msg}'
      },
      dropStage: {
        ok: 'Recruitment stage has been removed',
        error: 'Recruitment stage cannot be removed: {msg}'
      },
      delete: {
        ok: 'Recruitment has been deleted',
        error: 'Recruitment cannot be deleted: {msg}'
      },
      candidates: {
        move: {
          ok: 'Candidate has been moved',
          error: 'Candidate cannot be moved: {msg}'
        },
        update: {
          ok: 'Candidate has been updated',
          error: 'Candidate cannot be updated: {msg}'
        },
        delete: {
          ok: 'Candidate has been removed from recruitment',
          error: 'Candidate cannot be removed from recruitment: {msg}'
        },
      },
      documents: {
        index: {
          error: 'Recruit documents cannot be loaded: {msg}'
        },
        show: {
          error: 'Recruit document cannot be loaded: {msg}',
          positionError: 'Position cannot be blank',
          groupError: 'Group cannot be blank'
        },
        create: {
          ok: 'Recruit document has been created',
          error: 'Recruit document cannot be created: {msg}'
        },
        update: {
          ok: 'Recruit document has been updated',
          error: 'Recruit document cannot be updated: {msg}'
        },
        assign: {
          ok: 'Candidate has been added to recruitment',
          error: 'Candidate cannot be added to recruitment: {msg}'
        },
        destroy: {
          ok: 'Recruit document has been deleted',
          error: 'Recruit document cannot be deleted: {msg}'
        }
      },
      attachments: {
        upload: {
          ok: 'Attachments has been uploaded',
          error: 'Attachments cant be uploaded: {msg}'
        },
        delete: {
          ok: 'Attachment has been deleted',
          error: 'Attachment cannot be deleted: {msg}'
        },
      },
      inbox: {
        index: {
          error: 'Inbox cannot be loaded: {msg}'
        }
      }
    },
  },
  models: {
    employee: {
      justStarted: 'just started',
      firstTime: 'First time',
      unscheduled: 'Unscheduled',
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
        instruction: 'Select evaluation from list to see details',
        smile: 'Keep smiling as you have nothing to do here :)'
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
      }
    },
    notifications: {
      index: {
        title: 'Notifications'
      }
    },
    settings: {
      show: {
        title: 'Settings',
      },
      general: {
        title: 'General',
      },
      notifications: {
        title: 'Notifications'
      },
      profile: {
        title: 'Profile',
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
        nav: {
          evaluation: 'Evaluation',
          email: 'Email'
        }
      },
      show: {
        name: 'Template Name',
        destination: 'Destination',
        placeholder: {
          name: 'Employee Name',
          position: 'Position',
          hiredOn: 'Hired Date',
          completedAt: 'Completion Date',
        },
        autosave: {
          status: 'Autosave (every 3 min): {status}',
          success: 'Last autosave success: {datetime}',
          failure: 'Last autosave failure: {datetime}'
        }
      }
    },
    recruitments: {
      index: {
        title: 'Candidates',
        noRecruitments: 'You do not participate in any recruitment yet',
        nav: {
          recruitments: 'Recruitments',
          list: 'List',
          search: 'Search',
          overview: 'Overview',
          inbox: 'Inbox'
        }
      },
      inbox: {
        title: 'Inbox'
      },
      show: {
        title: 'Recruitment'
      },
      mailer: {
        title: 'To: {to}',
        signatureWarning: 'You have no signature yet. You can define it in your',
        profileSettings: 'profile settings'
      },
      overview: {
        monthSelectLabel: 'Select a Month',
        monthlyReport: 'Monthly Report',
        yearlyReport: 'Yearly Report - {year}',
        groupsChartTitle: 'Recruits By Groups',
        sourcesChartTitle: 'Recruits By Sources'
      }
    }
  }
}
