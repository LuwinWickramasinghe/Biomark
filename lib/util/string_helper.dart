String toCamelCase(String input) {
  return input
      .replaceAll(RegExp(r"[^a-zA-Z0-9 ]"), "") // Remove special characters (e.g., apostrophes)
      .split(' ') // Split by spaces
      .map((word) {
        // Capitalize the first letter of each word, except the first word
        if (input.indexOf(word) == 0) {
          return word.toLowerCase(); // Lowercase the first word
        } else {
          return word[0].toUpperCase() + word.substring(1).toLowerCase(); // Capitalize others
        }
      })
      .join(''); // Join words together to form camel case
}