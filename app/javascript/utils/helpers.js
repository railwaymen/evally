export const pluckUniq = (arr, attribute) => (
  _.filter(_.uniq(_.map(arr, attribute)), Boolean)
)

export const fetchError = ({ response }) => {
  if (typeof response.data !== 'object') return response.statusText

  const details = response.data.details.join(', ')
  return details !== '' ? details : response.data.message
}

export const colors = [
  '#EF5350',
  '#EC407A',
  '#AB47BC',
  '#7E57C2',
  '#5C6BC0',
  '#42A5F5',
  '#29B6F6',
  '#26C6DA',
  '#26A69A',
  '#66BB6A',
  '#9CCC65',
  '#D4E157',
  '#FFEE58',
  '#FFCA28',
  '#FFA726',
  '#FF7043',
  '#8D6E63',
  '#78909C',
  '#C62828',
  '#AD1457',
  '#6A1B9A',
  '#4527A0',
  '#283593',
  '#1565C0',
  '#0277BD',
  '#00838F',
  '#00695C',
  '#2E7D32',
  '#558B2F',
  '#9E9D24',
  '#F9A825',
  '#FF8F00',
  '#EF6C00',
  '#D84315',
  '#4E342E',
  '#37474F'
]
