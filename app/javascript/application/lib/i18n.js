const messages = {
  en: {
    buttons: {
      cancel: 'Cancel',
      complete: 'Complete',
      create: 'Create',
      delete: 'Delete'
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
    evaluations: {
      title: 'Evaluations',
      buttons: {
        add_new: 'New evaluation',
        complete_evaluation: 'Complete evaluation',
        save_draft: 'Save draft',
        reset: 'Undo changes',
        delete_evaluation: 'Delete evaluation',
        hide: 'Hide',
        show: 'Show'
      },
      flashes: {
        create: {
          success: 'Evaluation has been succefully created.',
          error: 'Evaluation cannot be created due to some error: {reason}'
        },
        fetch: {
          error: 'Evaluation cannot be loaded due to some error: {reason}'
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
        hired_at: 'hired at'
      },
      message: 'Select draft evaluation or create a new one.',
      sidebar: {
        search: 'Search ...',
        subheader: 'Evaluations drafts',
        subtitle: 'based on \'{name}\' template',
        no_items: 'There are no evaluations drafts'
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
    navbar: {
      dashboard: 'Dashboard',
      evaluations: 'Evaluations',
      employees: 'Employees',
      templates: 'Templates',
      archive: 'Archive',
      settings: 'Settings',
      logout: 'Logout'
    }
  },

  pl: {
    buttons: {
      cancel: 'Anuluj',
      complete: 'Zakończ',
      create: 'Utwórz',
      delete: 'Usuń'
    },
    destroy_modals: {
      default: {
        title: 'Usuń',
        confirm: 'Czy na pewno chcesz to usunąć?'
      },
      evaluation: {
        title: 'Usuń ocenę',
        confirm: 'Czy na pewno chcesz usunąć ocenę tego pracownika?'
      },
      employee: {
        title: 'Usuń pracownika',
        confirm: 'Czy na pewno chcesz usunąć tego pracownika?'
      },
      template: {
        title: 'Usuń szablon',
        confirm: 'Czy na pewno chcesz usunąć ten szablon?'
      }
    },
    evaluations: {
      title: 'Oceny',
      buttons: {
        add_new: 'Nowa ocena',
        complete_evaluation: 'Zakończ ocenę',
        save_draft: 'Zapisz szkic',
        reset: 'Cofnij zmiany',
        delete_evaluation: 'Usuń ocenę',
        hide: 'Ukryj',
        show: 'Pokaż'
      },
      flashes: {
        create: {
          success: 'Ocena została pomyślnie utworzona.',
          error: 'Wystąpił błąd podczas tworzenia szkicu: {reason}'
        },
        fetch: {
          error: 'Wystąpił błąd podczas wczytywania ocen: {reason}'
        },
        save: {
          success: 'Ocena została pomyślnie zapisana.',
          error: 'Wystąpił błąd podczas zapisu: {reason}'
        },
        complete: {
          success: 'Ocena została pomyślnie zakończona.',
          error: 'Wystąpił błąd podczas zapisu: {reason}'
        },
        delete: {
          success: 'Ocena została pomyślnie usunięta.',
          error: 'Wystąpił błąd podczas usuwania: {reason}'
        }
      },
      forms: {
        complete: {
          title: 'Zakończ ocenę',
          question: 'Czy na pewno chcesz zakończyć ocenę pracownika?',
          warning: 'Ta akcja jest ostateczna i nie można jej cofnąć.',
          next_label: 'Następne review'
        },
        create_title: 'Utwórz szkic',
        select_employee: 'Wybierz pracownika',
        select_template: 'Wybierz szablon',
        employee_label: 'Pracownik',
        template_label: 'Szablon',
        bool_no: 'Nie',
        bool_yes: 'Tak',
        hired_at: 'zatrudniono',
      },
      message: 'Wybierz szkic oceny z listy lub stwórz nowy.',
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Szkice ocen',
        subtitle: 'według szablonu \'{name}\'',
        no_items: 'Brak szkiców ocen'
      }
    },
    dashboard: {
      title: 'Cześć {name}!',
      common: {
        as: ' jako ',
        first_time: 'Pierwszy raz'
      },
      drafts: {
        title: 'Szkice',
        edit_tooltip: 'Edytuj',
        updated: 'Edytowano {date}'
      },
      upcoming: {
        title: 'Nadchodzące',
        new_tooltip: 'Utwórz'
      },
      activities: {
        title: 'Aktywności',
        no_activities: 'Brak aktywności',
        see_more: 'Więcej'
      }
    },
    navbar: {
      dashboard: 'Kokpit',
      evaluations: 'Oceny',
      employees: 'Pracownicy',
      templates: 'Szablony',
      archive: 'Archiwum',
      settings: 'Ustawienia',
      logout: 'Wyloguj'
    }
  }
}

export default messages