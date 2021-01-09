export default class InboxTableComposer {
  static requestQuery(options) {
    return {
      per_page: options.itemsPerPage,
      page: options.page,
      sort_by: options.sortBy[0] || 'created_at',
      sort_dir: options.sortDesc[0] ? 'desc' : 'asc'
    }
  }

  static tableOptions(params) {
    return {
      page: Number(params.page) || 1,
      itemsPerPage: Number(params.per_page) || 25,
      sortBy: params.sort_by ? [params.sort_by] : ['created_at'],
      sortDesc: params.sort_by ? [params.sort_dir === 'desc'] : [true]
    }
  }
}
