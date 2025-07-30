class GraphQLQuery {
  String filterScanQr = """
  query{
  transactions(filter: {
    qrstring: {
      eq: \$eq
    }
  }) {
    nodes{
      id
      qrstring      
      user{
        profiles{
          fullname
          address
          phone          
        }
      }
      bookings{
        id        
        is_verify_vaccine
        is_verify_kartukuning
        is_verify_customer
      }      
    }
  }
}
""";
}
