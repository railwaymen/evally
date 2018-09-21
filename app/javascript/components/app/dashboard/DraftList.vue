<template>
	<div class="box box--border-primary">
		<h3 class="box__header">Drafts</h3>

		<div class="box__list">
			<v-list two-line>
        <v-list-tile v-for="draft in drafts" :key="draft.id" avatar>
					<v-list-tile-avatar>
						<span>{{ draft.progress }}%</span>
					</v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title><strong>{{ draft.employee.fullname }}</strong> as <em>{{ draft.employee.position }}</em> - {{ draft.next_evaluation_date }}</v-list-tile-title>
            <v-list-tile-sub-title>Last update: {{ draft.updated_at }}</v-list-tile-sub-title>
          </v-list-tile-content>

					<v-list-tile-action>
						<div class="">
							<v-btn color="grey" flat icon>
								<v-icon>edit</v-icon>
							</v-btn>
							<span class="separator"></span>
							<v-btn color="red" flat icon>
								<v-icon>delete</v-icon>
							</v-btn>
						</div>
					</v-list-tile-action>
        </v-list-tile>
      </v-list>
		</div>
	</div>
</template>

<script>
export default {
	name: 'DraftsList',
	data () {
		return {
			drafts: [
				{ 
					id: 0,
					employee: {
						fullname: 'Rob Stark',
						position: 'Ruby on Rails Developer'
					},
					next_evaluation_date: 'May 2018',
					updated_at: '13:43 April 21, 20180',
					progress: 95,
					links: {
						update: '',
						delete: ''
					}
				},
				{ 
					id: 1,
					employee: {
						fullname: 'Grzegorz Zalewski',
						position: 'Android Developer'
					},
					next_evaluation_date: 'July 2018',
					updated_at: '09:13 April 28, 20180',
					progress: 67,
					links: {
						update: '',
						delete: ''
					}
				},
				{ 
					id: 2,
					employee: {
						fullname: 'Helmut Muller',
						position: 'SEO Specialist'
					},
					next_evaluation_date: 'July 2018',
					updated_at: '10:54 April 28, 20180',
					progress: 43,
					links: {
						update: '',
						delete: ''
					}
				},
				{ 
					id: 3,
					employee: {
						fullname: 'Ann Moore',
						position: 'Graphic Designer'
					},
					next_evaluation_date: 'July 2018',
					updated_at: '10:54 April 28, 20180',
					progress: 56,
					links: {
						update: '',
						delete: ''
					}
				},
				{ 
					id: 4,
					employee: {
						fullname: 'Jack Sparrow',
						position: 'Frontend Developer'
					},
					next_evaluation_date: 'July 2018',
					updated_at: '10:54 April 28, 20180',
					progress: 12,
					links: {
						update: '',
						delete: ''
					}
				}
			]
		}
	}
}
</script>