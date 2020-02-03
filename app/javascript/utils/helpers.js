export const pluckUniq = (arr, attribute) => (
  _.filter(_.uniq(_.map(arr, attribute)), Boolean)
)

export const fetchError = ({ response }) => {
  if (typeof response.data !== 'object') return response.statusText

  const details = response.data.details.join(', ')
  return details !== '' ? details : response.data.message
}
