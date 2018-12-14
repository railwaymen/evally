const messages = {
  en: {
    buttons: {
      archive: 'Archive',
      cancel: 'Cancel',
      complete: 'Complete',
      copy: 'Copy',
      create: 'Create',
      delete: 'Delete',
      edit: 'Edit',
      filter: 'Filter',
      hide: 'Hide',
      reset: 'Reset',
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
          success: 'Evaluation has been succefully deleted.',
          error: 'Evaluation cannot be destroyed due to some error: {reason}'
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
      archive: 'Archiwizuj',
      cancel: 'Anuluj',
      complete: 'Zakończ',
      copy: 'Skopiuj',
      create: 'Utwórz',
      delete: 'Usuń',
      edit: 'Edytuj',
      filter: 'Filtruj',
      hide: 'Ukryj',
      reset: 'Resetuj',
      show: 'Pokaż'
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
    archive: {
      title: 'Archiwum',
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Pracownicy i oceny',
        evaluations_subheader: 'Lista ocen ({count})',
        no_items: 'Brak pracowników',
        tabs: {
          employees: 'Pracownicy',
          activities: 'Aktywności'
        },
        filter_title: 'Filtruj wg dat',
        date_from: 'Od dnia',
        date_to: 'Do dnia'
      },
      messages: {
        no_activities: 'Brak aktywności w wybranych dniach.'
      },
      flashes: {
        fetch: {
          error: 'Wystąpił błąd podczas wczytywania aktywności: {reason}'
        }
      }
    },
    employees: {
      title: 'Pracownicy',
      buttons: {
        add_new: 'Nowy pracownik',
        permalink: 'Permalink',
        edit: 'Edytuj pracownika',
        archive: 'Przenieś do archiwum',
        delete: 'Usuń pracownika'
      },
      forms: {
        archive: {
          title: 'Przenieś do archiwum',
          warning: 'Nie ma możliwości cofnięcia tej akcji. Wszystkie szkice ocen tego pracownika zostaną usunięte!',
          text: 'Proszę podać powód przeniesienia pracownika do archiwum: ',
          too_experienced: 'Bogate doświadczenie',
          released: 'Koniec współpracy',
          released_at: 'Współpraca zakończona'
        },
        permalink: {
          title: 'Udostępnij link',
          text: 'Skopiuj link z dostępem do aktualnej oceny tego pracownika:'
        },
        create_title: 'Utwórz pracownika',
        edit_title: 'Edytuj pracownika',
        first_name: 'Imię',
        last_name: 'Nazwisko',
        position: 'Stanowisko',
        hired_at: 'Zatrudniony od',
        next_review: 'Następne review',
        cooperation: 'Współpraca',
        since: 'od',
        to: 'do'
      },
      flashes: {
        archive: {
          success: 'Pracownik został pomyślnie zarchiwizowany.',
          error: 'Wystąpił błąd podczas archiwizowania pracownika: {reason}'
        },
        create: {
          success: 'Pracownik został pomyślnie dodany.',
          error: 'Wystąpił błąd podczas dodawania pracownika: {reason}'
        },
        edit: {
          success: 'Pracownik został pomyślnie zapisany.',
          error: 'Wystąpił błąd podczas zapisywania pracownika: {reason}'
        },
        fetch: {
          error: 'Wystąpił błąd podczas wczytywania pracowników: {reason}'
        },
        delete: {
          success: 'Pracownik został pomyślnie usunięty.',
          error: 'Wystąpił błąd podczas usuwania pracownika: {reason}'
        },
        permalink: {
          success: 'Link został skopiowany do schowka.'
        }
      },
      messages: {
        select: 'Wybierz pracownika z listy, aby zobaczyć jego aktualną ocenę.',
        not_evaluated: '{name} nie został jeszcze oceniony.'
      },
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Lista pracowników',
        no_items: 'Brak pracowników'
      }
    },
    evaluations: {
      title: 'Oceny',
      buttons: {
        add_new: 'Nowa ocena',
        complete: 'Zakończ ocenę',
        save_draft: 'Zapisz szkic',
        reset: 'Cofnij zmiany',
        delete: 'Usuń ocenę'
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
        next_review: 'następne review',
        completed_at: 'zakończono'
      },
      message: 'Wybierz szkic oceny z listy lub stwórz nowy.',
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Szkice ocen',
        subtitle: 'według szablonu \'{name}\'',
        no_items: 'Brak szkiców ocen'
      }
    },
    templates: {
      title: 'Szablony',
      buttons: {
        add_new: 'Nowy szablon',
        edit: 'Edytuj szablon',
        save: 'Zapisz szablon',
        delete: 'Usuń szablon'
      },
      flashes: {
        create: {
          success: 'Szablon został pomyślnie stworzony.',
          error: 'Wystąpił błąd podczas tworzenia szablonu: {reason}'
        },
        fetch: {
          error: 'Wystąpił błąd podczas wczytywania szablonów: {reason}'
        },
        save: {
          success: 'Szalon został pomyślnie zapisany.',
          error: 'Wystąpił błąd podczas zapisywania szablonu: {reason}'
        },
        delete: {
          success: 'Szablon został pomyślnie usunięty.',
          error: 'Wystąpił błąd podczas usuwania szablonu: {reason}'
        }
      },
      forms: {
        template_name: 'Nazwa szablonu',
        section_title: 'Tytuł sekcji',
        buttons: {
          full_width: 'Szeroka',
          half_width: 'Wąska',
          delete: 'Usuń sekcję'
        },
        inputs: {
          text: 'Nowa pozycja tekstowa',
          rating: 'Nowa pozycja ratingowa',
          bool: 'Nowa pozycja prawda/fałsz'
        },
        new_section: {
          title: 'Nowa sekcja',
          width: {
            subheader: 'Szerokość: ',
            full: 'Szeroka',
            half: 'Wąska'
          },
          type: {
            subheader: 'Typ: ',
            rating: 'Ratingowy',
            boolean: 'Prawda/fałsz',
            text: 'Tekstowy'
          },
          button: 'Dodaj sekcję'
        }
      },
      messages: {
        select: 'Wybierz szablon z listy lub stwórz nowy.',
      },
      placeholders: {
        name: 'Imię Nazwisko',
        position: 'stanowisko'
      },
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Wszystkie szalobny',
        no_items: 'Brak szablonów'
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