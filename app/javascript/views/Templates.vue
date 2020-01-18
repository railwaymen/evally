<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('templates.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.add_new') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn slot="activator" icon flat>
              <v-icon>save_alt</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.save') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn slot="activator" icon flat>
              <v-icon>edit</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.edit') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn color="red" slot="activator" icon flat>
              <v-icon>delete</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.delete') }}</span>
          </v-tooltip>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <templates-search-list />
          </v-flex>

          <v-flex xs12 lg9>
            <v-form ref="templateForm">
              Template
            </v-form>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import TemplatesSearchList from '@components/templates/TemplatesSearchList'

export default {
  name: 'Templates',
  components: { TemplatesSearchList }
}
</script>
