class GraphQLMutation {
  String mutationVerifiedBookingManual = """
  mutation Mutation(\$bookingCode: String!) {
    verifiedBookingManual(bookingCode: \$bookingCode) {
      __typename
      ... on VerifiedBookingManualOK {
        status
        verifiedType
      }
      ... on Error {
        message
      }
    }
  }""";

  String mutationAssignTestBooth = """
  mutation (\$testBoothId: Int!) {
    assignTestBooth(testBoothId: \$testBoothId) {
      ... on AssignTestBoothOK {
        message
      }
      ... on Error {
        message
      }
    }
  }
  """;

  String mutationUpdateSwabber = """
  mutation Mutation(\$name: String!, \$employeeId: String!) {
    updateSwabber (name: \$name, employeeIdentifier: \$employeeId){
      __typename
      ... on User {
        name
        employeeIdentifier
        isFormSubmitted
      }
      ... on Error {
        message
      }
    }
  }
  """;

  
}
