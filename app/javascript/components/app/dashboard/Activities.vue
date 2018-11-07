<template>
	<div class="box box--border-grey">
		<h3 class="box__header text-xs-center">Activities (not implemented)</h3>

		<div class="box__list">
			<v-list two-line>
        <v-list-tile v-for="activity in activities" :key="activity.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ activity.title }}</v-list-tile-title>
          	<v-list-tile-sub-title>{{ activity.text }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
            <v-list-tile-action-text>{{ activity.timing }}</v-list-tile-action-text>
					</v-list-tile-action>
        </v-list-tile>
      </v-list>

			<a href="#" style="font-size: 1.6rem; color: black; text-align: center; display: block;">See more</a>
		</div>
	</div>
</template>

<script>
export default {
	name: 'Activities',
	data () {
		return {
			activities: [
				{ id: 0, title: 'Evaluation completed', text: "Rob Stark's evaluation has been completed", timing: '2h' },
				{ id: 1, title: 'New template', text: "Template for 'Rubies' has been created", timing: '8h' },
				{ id: 2, title: 'Template archived', text: "Template for 'Wizards' moved to archive", timing: '1d' },
				{ id: 3, title: 'Evaluation created', text: "John Doe's evaluation has been created", timing: '5d' },
				{ id: 4, title: 'New employee', text: "Welcome to new employee 'James'", timing: '2w' }
			]
		}
	}
}
</script>