# class: wildfly
# ===========================
class wildfly (
  Stdlib::Unixpath                                                                     $catalina_home = '/opt/wildfly',
  String                                                                               $user          = 'wildfly',
  String                                                                               $group         = 'wildfly',
  Boolean                                                                              $manage_user   = true,
  Boolean                                                                              $manage_group  = true,
  Boolean                                                                              $manage_base   = true,
  Hash[Enum['username','password'], String]                                            $mgmt_user = {
    'username' => 'puppet',
    'password' => fqdn_rand_string(30),
  },
  Hash[Enum['management-http','management-https','ajp','http','https'], Integer[1024]] $port_properties = {
    'management-http' => 9990,
    'management-https' => 9993,
    'ajp' => 8009,
    'http' => 8080,
    'https' => 8443,
  },
  Hash[Enum['management','public'], Stdlib::Compat::Ip_address]                        $ip_properties = {
    'management' => '127.0.0.1',
    'public'     => '127.0.0.1',
  },
) {

  unless ("${facts['operatingsystem']}${facts['operatingsystemrelease']}" =~ /((RedHat(6|7))|(Amazon2))/) {
    fail("Module ${module_name} is not supported on ${::facts['operatingsystem']} ${::facts['operatingsystemrelease']}.")
  }
}

