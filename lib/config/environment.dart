class Environment {
  /// name of the environment
  final String name;

  /// default constructor
  const Environment(this.name);

  /// preset of common env name 'dev'
  static const String dev = 'development';

  /// preset of common env name 'prod'
  static const String prod = 'production';

  /// preset of common env name 'test'
  static const String test = 'testing';
}
