export default {
  shared: {
    buttons: {
      cancel: 'Anuluj',
      create: 'Utwórz',
      update: 'Aktualizuj',
      delete: 'Usuń',
      complete: 'Zakończ',
      search: 'Szukaj',
      reset: 'Resetuj',
      save: 'Zapisz',
      changePassword: 'Zmień hasło',
      yes: 'Tak',
      no: 'Nie',
    },
    tooltips: {
      edit: 'Edytuj',
      create: 'Utwórz',
      addNew: 'Nowy',
      complete: 'Zakończ',
      save: 'Zapisz',
      reset: 'Resetuj',
      delete: 'Usuń',
      hideSidebar: 'Ukryj sidebar',
      showSidebar: 'Pokaż sidebar',
      fullWidth: 'Rozciągnij',
      halfWidth: 'Zwęź',
      copyLink: 'Skopiuj link',
      close: 'Zamknij'
    },
    navbar: {
      dashboard: 'Kokpit',
      drafts: 'Szkice ocen',
      employees: 'Pracownicy',
      templates: 'Szablony',
      settings: 'Ustawienia',
      users: 'Użytkownicy',
      logout: 'Wyloguj',
    },
    validations: {
      required: 'To pole jest wymagane',
      min6: 'Wymanage co najmniej 6 znaków',
      isString: 'Musi być ciągiem znaków',
      confirmed: 'Oba hasła muszą być identyczne'
    }
  },
  components: {
    dashboard: {
      activitiesFeed: {
        title: 'Ostatnie aktywności',
        noContent: 'Brak aktywności',
      },
      drafts: {
        title: 'Szkice ocen',
        noContent: 'Brak szkiców ocen',
        as: 'jako',
        updated: 'Edytowano {date}',
      },
      upcoming: {
        title: 'Nadchodzące',
        as: 'jako',

      }
    },
    drafts: {
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Oceny w przygotowaniu',
        subtitle: 'na podstawie szablonu \'{name}\'',
        noContent: 'Brak szkiców ocen'
      },
      section: {
        yes: 'Tak',
        no: 'Nie',
      },
      deleteConfirm: {
        title: 'Usuń szkic',
        body: 'Czy na pewno chcesz usunąć ten szkic?'
      },
      completeForm: {
        title: 'Zakończ ocenę',
        question: 'Czy na pewno chcesz zakończyć ocenę pracownika?',
        warning: 'Ta akcja jest ostateczna i nie można jej cofnąć.',
        nextEvaluation: 'Następna ocena',
      },
      createForm: {
        title: 'Utwórz szkic',
        selectEmployee: 'Wybierz pracownika',
        employeeLabel: 'Pracownik',
        selectTemplate: 'Wybierz szablon',
        templateLabel: 'Szablon',
        latestTemplate: 'Ostatni szablon',
        newTemplate: 'Nowy szablon',
      }
    },
    employees: {
      table: {
        search: 'Szukaj ...',
        cols: {
          name: 'Nazwa',
          hiredOn: 'Data zatrudnienia',
          group: 'Grupa',
          position: 'Stanowisko',
          positionSetOn: 'Data zmiany stanowiska',
          latestEvaluationAt: 'Data ostatniej oceny',
        }
      },
      deleteConfirm: {
        title: 'Usuń pracownika',
        body: 'Czy na pewno chcesz usunąć tego pracownika?'
      },
      searchTable: {
        cols: {
          name: 'Nazwa',
          skill: 'Umiejętność',
          hiredOn: 'Data zatrudnienia',
          group: 'Grupa',
          position: 'Stanowisko',
          positionSetOn: 'Data zmiany stanowiska',
          latestEvaluationAt: 'Data ostatniej oceny',
        },
        labels: {
          yes: 'Tak',
          no: 'Nie',
        }
      },
      employeeForm: {
        createTitle: 'Utwórz pracownika',
        updateTitle: 'Zaktualizuj pracownika',
        general: 'Informacje ogólne',
        dates: 'Daty',
        firstName: 'Imię',
        lastName: 'Naswisko',
        position: 'Stanowisko',
        group: 'Grupa',
        hiredOn: 'Data zatrudnienia',
        positionSetOn: 'Data zmiany stanowiska',
        nextEvaluationOn: 'Data ostatniej evaluacji'
      },
      sidebar: {
        group: 'Groupa',
        hiredOn: 'Data zatrudnienia',
        nextEvaluationOn: 'Data ostatniej evaluacji',
        completedEvaluations: {
          title: 'Zakończone ocenę',
          noContent: 'Brak ocen'
        },
        positionChanges: {
          title: 'Zmiany stanowiska',
          previous: 'Poprzednio: {name}',
          noContent: 'Brak zmian',
        }
      },
      positionsChart: {
        title: 'Podział stanowisk'
      },
      averageEmployment: {
        title: 'Śr. czas zatrudnienia'
      }
    },
    evaluations: {
      staticSection: {
        yes: 'Tak',
        no: 'Nie',
      }
    },
    settings: {
      sidebarNav: {
        general: 'Ogólne',
        profile: 'Profil',
        support: 'Wsparcie',
      },
      generalForm: {
        language: {
          subtitle: 'Język',
          english: 'angielski',
          polish: 'polski',
        },
        widgets: {
          subtitle: 'Widgety',
          drafts: 'Ilość szkiców ocen',
          upcoming: 'Ilość nadchodzących ocen'
        },
        evaluations: {
          subtitle: 'Oceny',
          nextEvaluationOffset: 'Miesiące do następnej oceny'
        }
      },
      userForm: {
        subtitle: 'Podstawowe informacje',
        email: 'Email',
        firstName: 'Imię',
        lastName: 'Nazwisko',
      },
      passwordForm: {
        subtitle: 'Zmień hasło',
        newPassword: 'Nowe hasło',
        passwordConfirmation: 'Potwierdź hasło',
        password: 'Obecne hasło',
      }
    },
    templates: {
      sidebar: {
        search: 'Szukaj ...',
        subheader: 'Dostępne szablony',
        noContent: 'Brak szablonów'
      },
      deleteConfirm: {
        title: 'Usuń szablon',
        body: 'Czy na pewno chcesz usunąć ten szablon?'
      },
      sectionForm: {
        title: 'Nowa sekcja',
        width: {
          title: 'Szerokość',
          full: 'Szeroka',
          half: 'Wąska',
        },
        group: {
          title: 'Typ',
          rating: 'Ratingowy',
          bool: 'Tak/Nie',
          text: 'Tekstowy',
        },
        button: 'Dodaj sekcję'
      },
      sectionItemsList: {
        label: {
          rating: 'Nowa pozycja ratingowa',
          bool: 'Nowa pozycja tak/nie',
          text: 'Nowa pozycja tekstowa',
        }
      },
      sectionComposer: {
        title: 'Tytuł sekcji'
      }
    }
  },
  messages: {
    drafts: {
      index: {
        error: 'Błąd przy wczytywaniu szkiców ocen: {msg}'
      },
      show: {
        error: 'Błąd przy wczytywaniu szkicu oceny: {msg}'
      },
      create: {
        ok: 'Szkic oceny został utworzony',
        error: 'Błąd przy tworzeniu szkicu oceny: {msg}'
      },
      update: {
        ok: 'Szkic oceny został zaktualizowany',
        error: 'Błąd przy aktualizacji szkicu oceny: {msg}'
      },
      complete: {
        ok: 'Ocena została zakończona',
        error: 'Błąd przy zakończeniu oceny: {msg}'
      },
      delete: {
        ok: 'Szkic oceny został usunięty',
        error: 'Błąd przy usuwaniu szkicu oceny: {msg}'
      }
    },
    employees: {
      index: {
        error: 'Błąd przy wczytywaniu pracowników: {msg}'
      },
      show: {
        error: 'Błąd przy wczytywaniu pracownika: {msg}',
        copyLink: 'Link został skopiowany do schowka'
      },
      showEvaluation: {
        error: 'Błąd przy wczytywaniu oceny pracownika: {msg}'
      },
      create: {
        ok: 'Pracownik został utworzony',
        error: 'Błąd przy tworzeniu pracownika: {msg}'
      },
      update: {
        ok: 'Pracownik został zaktualizowany',
        error: 'Błąd przy aktualizacji pracownika: {msg}'
      },
      delete: {
        ok: 'Pracownik został usunięty',
        error: 'Błąd przy usuwaniu pracownika: {msg}'
      }
    },
    session: {
      show: {
        error: 'Błąd przy wczytywaniu ustawień: {msg}'
      },
      create: {
        ok: 'Zostałeś poprawnie zalogowany',
        error: 'Niepoprawny email lub hasło, spróbuj ponownie'
      },
      updateSetting: {
        ok: 'Ustawienia zostały zapisane',
        error: 'Błąd przy zapisywaniu ustawień: {msg}'
      },
      updateUser: {
        ok: 'Profil został zaktualizowany',
        error: 'Błąd przy aktualizacji profilu: {msg}'
      },
      updatePassword: {
        ok: 'Hasło zostało zmienione, zaloguj się ponownie',
        error: 'Błąd przy zmianie hasła: {msg}'
      },
      destroy: {
        ok: 'Zostałeś wylogowany'
      }
    },
    templates: {
      index: {
        error: 'Błąd przy wczytywaniu szablonów: {msg}'
      },
      show: {
        error: 'Błąd przy wczytywaniu szablonu: {msg}'
      },
      create: {
        ok: 'Szablon został utworzony',
        error: 'Błąd przy tworzeniu szablonu: {msg}'
      },
      update: {
        ok: 'Szablon został zaktualizowany',
        error: 'Błąd przy aktualizacji szablonu: {msg}'
      },
      delete: {
        ok: 'Szablon został usunięty',
        error: 'Błąd przy usuwaniu szablonu: {msg}'
      }
    }
  },
  models: {
    employee: {
      justStarted: 'pczątkujący',
      firstTime: 'Pierwszy raz',
      works: 'pracuje od',
      month: '{n} miesiąca | {n} miesięcy',
      year: '{n} roku | {n} lat',
      and: 'i',
    },
    employeesAnalytics: {
      month: '{n} miesiące | {n} miesięcy',
      year: '{n} roku | {n} lat',
      and: 'i',
    }
  },
  views: {
    dashboards: {
      show: {
        title: 'Witaj {name}!',
      }
    },
    drafts: {
      index: {
        title: 'Szkice ocen',
        instruction: 'Wybiesz szkic oceny z listy obok lub stwórz nowy',
      },
      show: {
        hiredOn: 'Data zatrudnienia',
      }
    },
    employees: {
      index: {
        title: 'Pracownicy',
        nav: {
          list: 'Lista',
          search: 'Wyszukaj',
          overview: 'Przegląd',
        },
      },
      show: {
        instruction: 'Wybierz ocenę z listy obok aby wyświetlić szczegóły'
      },
      evaluation: {
        hiredOn: 'Data zatrudnienia',
        completedAt: 'Data zakończenia',
      },
      search: {
        label: 'Umięjętność',
      }
    },
    settings: {
      show: {
        title: 'Ustawienia',
      },
      general: {
        title: 'Ustawienia gólne',
      },
      profile: {
        title: 'Ustawienia profilu',
        logOutWarning: 'Poprawna zmiana hasła spowoduje wylogowanie użytkownika',
      },
      support: {
        title: 'Pomoc',
        text: 'Wkrótce...'
      }
    },
    templates: {
      index: {
        title: 'Szablony',
        instruction: 'Wybierz szablon z listy obok lub stwórz nowy',
      },
      show: {
        label: 'Nazwa szablonu',
        placeholder: {
          name: 'Imię i nazwisko',
          position: 'Stanowisko',
          hiredOn: 'Data zatrudnienia',
          completedAt: 'Data zakończenia',
        }
      }
    }
  }
}
