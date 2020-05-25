export default {
  shared: {
    general:{
      fields: {
        firstName: 'Imię',
        lastName: 'Nazwisko',
        email: 'Email',
        phoneNumber: 'Numer telefonu',
        source: 'Żródło',
        status: 'Status',
        group: 'Grupa',
        evaluator: 'Oceniający'
      }
    },
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
      archive: 'Archiwizuj'
    },
    tooltips: {
      edit: 'Edytuj',
      create: 'Utwórz',
      addNew: 'Nowy',
      addEvaluation: 'Nowa ocena',
      complete: 'Zakończ',
      save: 'Zapisz',
      reset: 'Resetuj',
      delete: 'Usuń',
      hideSidebar: 'Ukryj sidebar',
      showSidebar: 'Pokaż sidebar',
      fullWidth: 'Rozciągnij',
      halfWidth: 'Zwęź',
      copyLink: 'Skopiuj link',
      close: 'Zamknij',
      archive: 'Archiwizuj',
      openInfo: 'Otwarte dane',
      sensitiveInfo: 'Wrażliwe dane'
    },
    navbar: {
      dashboard: 'Kokpit',
      evaluations: 'Oceny',
      employees: 'Pracownicy',
      recruitments: 'Rekrutacje',
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
    evaluations: {
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
        title: 'Usuń szkic oceny',
        body: 'Czy na pewno chcesz usunąć ten szkic oceny?'
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
      },
      staticSection: {
        yes: 'Tak',
        no: 'Nie',
      }
    },
    employees: {
      table: {
        search: 'Szukaj ...',
        groupFilter: 'Grupa',
        evaluatorFilter: 'Ewaluator',
        cols: {
          name: 'Nazwa',
          hiredOn: 'Data zatrudnienia',
          group: 'Grupa',
          position: 'Stanowisko',
          positionSetOn: 'Data zmiany stanowiska',
          currentEvaluator: 'Obecny ewaluator',
          latestEvaluationAt: 'Data ostatniej oceny',
          archivedOn: 'Data archiwizacji',
        }
      },
      deleteConfirm: {
        title: 'Usuń pracownika',
        body: 'Czy na pewno chcesz usunąć tego pracownika?'
      },
      archiveForm: {
        title: 'Archiwizuj pracownika',
        body: 'Czy na pewno chcesz archiwizować tego pracownika?',
        dateRequest: 'Proszę podać datę archiwizacji pracownika: ',
        archivedOn: 'Date archiwizacji'
      },
      searchTable: {
        cols: {
          name: 'Nazwa',
          skill: 'Umiejętność',
          hiredOn: 'Data zatrudnienia',
          group: 'Grupa',
          position: 'Stanowisko',
          positionSetOn: 'Data zmiany stanowiska',
          currentEvaluator: 'Obecny ewaluator',
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
        general: 'Ogólne',
        employment: 'Zatrudnienie',
        evaluation: 'Ocena',
        firstName: 'Imię',
        lastName: 'Naswisko',
        position: 'Stanowisko',
        group: 'Grupa',
        hiredOn: 'Data zatrudnienia',
        positionSetOn: 'Data zmiany stanowiska',
        nextEvaluationOn: 'Data ostatniej oceny',
        evaluator: 'Ewaluator'
      },
      sidebar: {
        group: 'Groupa',
        hiredOn: 'Data zatrudnienia',
        nextEvaluationOn: 'Data ostatniej oceny',
        archivedOn: 'Data archiwizacji',
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
      employeesPastYearChart: {
        title: 'Zmiany pracowników wg miesięcy',
        hiredEmployees: 'Zatrudnieni',
        archivedEmployees: 'Zarchiwizowani'
      },
      evaluationsPastYearChart: {
        title: 'Ukończone oceny wg miesięcy',
        completedEvaluations: 'Ukończone oceny'
      },
      employeesByUsersChart: {
        title: 'Pracownicy wg ewaluatorów',
        employees: 'Pracownicy'
      }
    },
    layout: {
      notificationsMenu: {
        title: 'Powiadomienia',
        noNotifications: 'Brak powiadomień',
        readAll: 'Czyaj wszystkie',
        seeMore: 'Więcej'
      }
    },
    shared: {
      searchBySkillForm: {
        label: 'Umiejętność'
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
        createdBy: 'stworzony przez {name}',
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
        sensitive: {
          title: 'Dane wrażliwe',
          yes: 'Tak',
          no: 'Nie'
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
    },
    users: {
      table: {
        search: 'Szukaj ...',
        you: 'ty',
        cols: {
          name: 'Nazwa',
          email: 'Email',
          role: 'Rola',
          latestActivity: 'Ostatnia aktywność',
          status: 'Status',
          invitationStatus: 'Status zaproszenia',
        }
      },
      userForm: {
        createTitle: 'Utwórz użytkownika',
        updateTitle: 'Zaktualizuj użytkownika',
        email: 'Email',
        firstName: 'Imię',
        lastName: 'Nazwisko',
        role: 'Rola',
        status: 'Status'
      }
    },
    recruitments: {
      table: {
        search: 'Szukaj ...',
        groupFilter: 'Grupa',
        statusFilter: 'Status',
        cols: {
          email: 'Email',
          group: 'Grupa',
          status: 'Status',
          position: 'Pozycja',
          source: 'Źródło',
          receivedAt: 'Data otrzymania',
          acceptCurrentProcessing: 'OP',
          acceptFutureProcessing: 'PP'
        }
      },
      searchTable: {
        labels: {
          yes: 'Tak',
          no: 'Nie'
        },
        cols: {
          name: 'Nazwa',
          skill: 'Umiejętność',
          group: 'Grupa',
          position: 'Stanowisko',
          source: 'Źródło',
          receivedDate: 'Data otrzymania',
          status: 'Status',
          evaluationDate: 'Data oceny',
          evaluatorName: 'Ewaluator',
          acceptCurrentProcessing: 'OP',
          acceptFutureProcessing: 'PP'
        }
      },
      recruitmentForm: {
        createTitle: 'Nowe zgłoszenie rekrutacyjne',
        contact: 'Kontakt',
        general: 'Ogólne',
        agreements: 'Zgody',
        addFiles: 'Dodaj pliki ...',
        male: 'mężczyzna',
        female: 'kobieta',
        position: 'Stanowisko',
        receivedDate: 'Data odebrania',
        acceptCurrentProcessing: 'Zgoda na obecną rekrutację',
        acceptFutureProcessing: 'Zgoda na przyszłe rekrutacje',
        attachments: 'Załączniki',
        socials: 'Społeczności'
      },
      deleteConfirm: {
        title: 'Usuń zgłoszenie rekrutacyjne',
        body: 'Czy na pewno chcesz usunąć to zgłoszenie?'
      },
      recruitmentFilePreview: {
        label: 'Wybierz załączony plik'
      },
      createEvaluationForm: {
        title: 'Stwórz ocenę',
        selectTemplate: 'Wybierz szablon',
        templateLabel: 'Nazwa szablonu'
      },
      evaluationsSidebar: {
        selectLabel: 'Ocena'
      },
      deleteAttachmentConfirm: {
        title: 'Usuń plik',
        body: 'Czy na pewno chcesz usunąć ten plik?'
      },
      deleteCommentConfirm: {
        title: 'Usuń komentarz',
        body: 'Czy na pewno chcesz usunąć ten komentarz?'
      },
      sidebar: {
        contactInformation: 'Dane kontaktowe',
        applicationDetails: 'Szczegóły zgłoszenia',
        attachments: 'Dołączone pliki ({n})',
        gender: 'Płeć',
        nationality: 'Narodowość',
        email: 'Email',
        phoneNumber: 'Numer telefonu',
        status: 'Status',
        group: 'Grupa',
        position: 'Stanowisko',
        evaluator: 'Oceniający',
        source: 'Źródło',
        receivedDate: 'Data otrzymania',
        addFile: 'Doda plik'
      },
      statusChangeForm: {
        title: 'Zmień status'
      }
    }
  },
  messages: {
    comments: {
      create: {
        ok: 'Komentarz został dodany',
        error: 'Błąd przy dodawaniu domentarza: {msg}'
      },
      update: {
        ok: 'Komentarz został zaktualizowany',
        error: 'Błąd przy aktualizacji komentarza: {msg}'
      },
      delete: {
        ok: 'Komentarz został usunięty',
        error: 'Błąd przy usuwaniu komentarza: {msg}'
      }
    },
    evaluations: {
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
      archived: {
        error: 'Błąd przy wczytywaniu zarchiwizowanych pracowników: {msg}'
      },
      overview: {
        error: 'Błąd przy wczytywaniu danych: {msg}'
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
      },
      archive: {
        ok: 'Pracownik został zarchiwizoway',
        error: 'Błąd przy archiwizacji pracownika: {msg}'
      },
    },
    session: {
      acceptInvitation: {
        ok: 'Twoje hasło zostało zapisane. Możesz się teraz zalogować',
        error: 'Błąd przy zapisywaniu hasła: {msg}'
      },
      forgotPassword: {
        ok: 'Jesli konto istnieje, wyślemy Ci instrukcję do zresetowania hasła'
      },
      resetPassword: {
        ok: 'Twoje hasło zostało zapisane i możesz się teraz zalogować',
        error: 'Błąd przy zapisywaniu hasła: {msg}'
      },
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
    },
    users: {
      index: {
        error: 'Błąd przy wczytywaniu użytkowników: {msg}'
      },
      create: {
        ok: 'Użytkownik został utworzony',
        error: 'Błąd przy tworzeniu użytkownika: {msg}'
      },
      update: {
        ok: 'Użytkownik został zaktualizowany',
        error: 'Błąd przy aktualizacji użytkownika: {msg}'
      }
    },
    recruitments: {
      index: {
        error: 'Błąd przy ładowaniu zgłoszeń rekrutacyjnych: {msg}'
      },
      create: {
        ok: 'Zgłoszenie rekrutacyjne zostało utworzone',
        error: 'Błąd przy tworzeniu zgłoszenia rekrutacyjnego: {msg}'
      },
      update: {
        ok: 'Zgłoszenie rekrutacyjne zostało zaktualizowane',
        error: 'Błąd przy aktualizacji zgłoszenia rekrutacyjnego: {msg}'
      },
      show: {
        error: 'Błąd przy ładowaniu zgłoszenia rekrutacyjnego: {msg}',
        positionError: 'Stanowisko nie może być puste',
        groupError: 'Grupa nie może być pusta'
      },
      destroy: {
        ok: 'Zgłoszenie rekrutacyjne zostało usunięte',
        error: 'Błąd przy usuwaniu zgłoszenia rekrutacyjnego: {msg}'
      },
      uploadFiles: {
        ok: 'Plik został wgrany',
        error: 'Błąd przy wgrywaniu pliku: {msg}'
      },
      destroyFile: {
        ok: 'Plik został usunięty',
        error: 'Błąd przy usuwaniu pliku: {msg}'
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
    user: {
      roles: {
        admin: 'Admin',
        evaluator: 'Ewaluator'
      },
      statuses: {
        active: 'Aktywny',
        inactive: 'Nieaktywny'
      },
      invitationStatuses: {
        pending: 'Oczekujące',
        accepted: 'Zaakceptowano'
      }
    }
  },
  views: {
    browser: {
      show: {
        instruction: 'Wprowadź swoje nazwisko, aby zobaczyć swoje oceny: '
      }
    },
    dashboards: {
      show: {
        title: 'Witaj {name}!',
      }
    },
    evaluations: {
      index: {
        title: 'Ocen',
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
          archived: 'Archiwizowani',
        },
      },
      show: {
        instruction: 'Wybierz ocenę z listy obok aby wyświetlić szczegóły'
      },
      evaluation: {
        hiredOn: 'Data zatrudnienia',
        completedAt: 'Data zakończenia',
      },
      overview: {
        employment: 'Zatrudnienie',
        evaluations: 'Oceny',
        tiles: {
          averageEmployment: 'Średni czas',
          employees: 'Pracownicy',
          changesThisYear: 'Zmiany w {year} roku',
          months: 'miesiąc | miesiące',
          years: 'rok | lata',
          hired: 'Zatrudnieni',
          archived: 'Zarchiwizowani',
          new: 'Nowi',
          averageEvaluations: 'Średnia ilość ocen',
          evaluationsPerEmployee: 'Na pracownika',
          allEvaluations: 'Wszystkie oceny',
          evaluationsThisYear: 'Oceny w {year} roku',
          completed: 'Ukończone'
        }
      }
    },
    notifications: {
      index: {
        title: 'Powiadomienia'
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
        name: 'Nazwa szablonu',
        destination: 'Przeznaczenie',
        placeholder: {
          name: 'Imię i nazwisko',
          position: 'Stanowisko',
          hiredOn: 'Data zatrudnienia',
          completedAt: 'Data zakończenia',
        }
      }
    },
    recruitments: {
      index: {
        title: 'Rekrutacje',
        nav: {
          list: 'Lista',
          search: 'Wyszukaj',
          overview: 'Przegląd'
        }
      },
      show: {
        title: 'Rekrutacja'
      },
      overview: {
        monthSelectLabel: 'Wybierz miesiąc',
        monthlyReport: 'Raport miesięczny',
        yearlyReport: 'Raport roczny - {year}',
        groupsChartTitle: 'Rekruci wg grupy',
        sourcesChartTitle: 'Recruci wg źródła'
      }
    }
  }
}
