<template>
	<div class="box box--border-primary">
		<h3 class="box__header">Upcoming</h3>

		<div class="box__list">
			<v-list>
        <v-list-tile v-for="draft in drafts" :key="draft.id" avatar>

          <v-list-tile-content>
            <v-list-tile-title><strong>{{ draft.employee.fullname }}</strong> as <em>{{ draft.employee.position }}</em> - {{ draft.next_evaluation_date }}</v-list-tile-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<v-btn color="green" icon flat>
							<v-icon>add</v-icon>
						</v-btn>
					</v-list-tile-action>
        </v-list-tile>
      </v-list>
		</div>
	</div>
</template>

<script>
export default {
	name: 'UpcomingList',
	data () {
		return {
			drafts: [
				{ 
					id: 0,
					employee: {
						fullname: 'Kent Clark',
						position: 'Copy writer'
					},
					next_evaluation_date: 'August 2018',
					links: {
						create: ''
					}
				},
				{ 
					id: 1,
					employee: {
						fullname: 'Rose Staphard',
						position: 'Junior Project Manager'
					},
					next_evaluation_date: 'August 2018',
					links: {
						create: ''
					}
				},
				{ 
					id: 2,
					employee: {
						fullname: 'Wendy Craig',
						position: 'Junior DevOps'
					},
					next_evaluation_date: 'September 2018',
					links: {
						create: ''
					}
				},
				{ 
					id: 3,
					employee: {
						fullname: 'Tom Walker',
						position: 'QA'
					},
					next_evaluation_date: 'September 2018',
					links: {
						create: ''
					}
				},
				{ 
					id: 4,
					employee: {
						fullname: 'Le Chiffre',
						position: 'Gambling Consultant'
					},
					next_evaluation_date: 'September 2018',
					links: {
						create: ''
					}
				}
			]
		}
	}
}
</script>