window.logger =
  enabled: false
  level: 3

  DEBUG: 3
  INFO: 2
  WARN: 1
  ERROR: 0

  output: (action, args...) ->
    if not logger.enabled or logger.level < logger[action]
      return

    args.unshift("#{action}: ")
    console?[action.toLowerCase()]?(args...)

  debug: (args...) ->
    logger.output('DEBUG', args...)

  info: (args...) ->
    logger.output('INFO', args...)

  warn: (args...) ->
    logger.output('WARN', args...)

  error: (args...) ->
    logger.output('ERROR', args...)