export default {
  buttons: {
    archive: 'Archiwizuj',
    cancel: 'Anuluj',
    change_pass: 'Zmień hasło',
    complete: 'Zakończ',
    copy: 'Skopiuj',
    create: 'Utwórz',
    delete: 'Usuń',
    edit: 'Edytuj',
    filter: 'Filtruj',
    hide: 'Ukryj',
    reset: 'Resetuj',
    save: 'Zapisz',
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
  settings: {
    title: 'Ustawienia',
    sidebar: {
      general: 'Ogólne',
      evaluations: 'Moduł ocen',
      profile: 'Profil',
      support: 'Wsparcie'
    },
    flashes: {
      save_setting: {
        success: 'Ustawienia zostały pomyślnie zapisane.',
        error: 'Wystąpił błąd podczas zapisywania ustawień: {reason}'
      },
      update_user: {
        success: 'Profil użytkownika został pomyślnie zapisany.',
        error: 'Wystąpił błąd podczas zapisu profilu użytkownika: {reason}'
      },
      update_pass: {
        success: 'Hasło zostało pomyślnie zmienione.',
        error: 'Wystąpił błąd podczas zmiany hasła: {reason}'
      }
    },
    general: {
      title: 'Ustawienia ogólne',
      language: {
        subheader: 'Język',
        polish: 'polski',
        english: 'angielski'
      },
      widgets: {
        subheader: 'Widgety ',
        draft_items: 'Ilość pozycji szkiców',
        upcoming_items: 'Ilość pozycji nadchodzących ocen'
      }
    },
    evaluations: {
      title: 'Ustawienia modułu ocen',
      defaults: {
        subheader: 'Domyślne opcje',
        next_review_offset: 'Okres do następnego review [mies]'
      }
    },
    profile: {
      title: 'Ustawienia profilu',
      basic: {
        subheader: 'Podstawowe informacje',
        email: 'Email',
        first_name: 'Imię',
        last_name: 'Nazwisko'
      },
      password: {
        subheader: 'Zmiana hasła',
        warning: 'Po pomyślnej zmianie hasłą nastąpi wylogowanie użytkownika.',
        new_pass: 'Nowe hasło',
        old_pass: 'Stare hasło',
        confirm_pass: 'Potwierdzenie hasła'
      }
    },
    support: {
      title: 'Wsparcie',
      text: 'Wkrótce ...'
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
  },
  validation: {
    required: 'To pole jest wymagane.',
    min6: 'To pole musi zawierać co najmniej 6 znaków.',
    isString: 'Musi być ciągiem znaków',
    confirmed: 'Oba hasła powinny być indentyczne.'
  }
}