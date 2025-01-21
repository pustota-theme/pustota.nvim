#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*-----------------------------------------------------
 * Preprocessor / Macros
 *-----------------------------------------------------*/
#define FEATURE_LEVEL 2
#define SQUARE(x) ((x) * (x))
#if FEATURE_LEVEL >= 2
    #define DEBUG_PRINT(fmt, ...) printf("[DEBUG] " fmt "\n", ##__VA_ARGS__)
#else
    #define DEBUG_PRINT(fmt, ...)
#endif

/*-----------------------------------------------------
 * Global variables
 *-----------------------------------------------------*/
static int globalCounter = 0;   /* static global */
const char *GLOBAL_MSG = "Hello, Global!";

/*-----------------------------------------------------
 * Typedef, Enums, Struct, Union
 *-----------------------------------------------------*/
typedef unsigned long ULong;

enum Color {
    RED = 1,
    GREEN,
    BLUE
};

struct Point {
    int x;
    int y;
};

union DataValue {
    int iVal;
    float fVal;
    char cVal;
};

/*-----------------------------------------------------
 * Function pointer
 *-----------------------------------------------------*/
typedef void (*ActionFunc)(const char *);

/*-----------------------------------------------------
 * Function Declarations
 *-----------------------------------------------------*/
inline int add(int a, int b);
static void printMessage(const char *msg);
static void incrementCounter(void);
ActionFunc getActionFunction(void);

/*-----------------------------------------------------
 * Inline Function Definition
 *-----------------------------------------------------*/
inline int add(int a, int b) {
    return a + b;
}

/*-----------------------------------------------------
 * Static Function Definitions
 *-----------------------------------------------------*/
static void printMessage(const char *msg) {
    /* Goto usage (not recommended, but shown here for demonstration) */
    goto PRINT_LABEL;

PRINT_LABEL:
    printf("%s\n", msg);
}

static void incrementCounter(void) {
    globalCounter++;
}

/*-----------------------------------------------------
 * A function returning a function pointer
 *-----------------------------------------------------*/
ActionFunc getActionFunction(void) {
    return printMessage;
}

/*-----------------------------------------------------
 * Main Function
 *-----------------------------------------------------*/
int main(void) {
    /* Local variables */
    enum Color chosenColor = GREEN;
    struct Point pt = { 10, 20 };
    union DataValue val;
    val.iVal = 42;

    /* Print debug info if FEATURE_LEVEL >= 2 */
    DEBUG_PRINT("Starting the program with feature level %d", FEATURE_LEVEL);

    /* Use arrays, pointers, memory allocation, string functions */
    char *dynamicString = malloc(50 * sizeof(char));
    if (!dynamicString) {
        fprintf(stderr, "Memory allocation failed!\n");
        return 1;
    }
    strcpy(dynamicString, "Allocated String");
    printf("Dynamically allocated string: %s\n", dynamicString);

    /* Control flow examples */
    printf("Control Flow Demo:\n");
    /* if-else */
    if (chosenColor == RED) {
        printf("Chosen color is RED\n");
    } else if (chosenColor == GREEN) {
        printf("Chosen color is GREEN\n");
    } else {
        printf("Chosen color is BLUE\n");
    }

    /* switch */
    switch (pt.x) {
        case 10:
            printf("Point.x is 10!\n");
            break;
        default:
            printf("Point.x is something else!\n");
            break;
    }

    /* for loop */
    for (int i = 0; i < 3; i++) {
        printf("for loop iteration %d\n", i);
    }

    /* while loop */
    int count = 0;
    while (count < 3) {
        printf("while loop iteration %d\n", count);
        count++;
    }

    /* do-while loop */
    int num = 0;
    do {
        printf("do-while iteration %d\n", num);
        num++;
    } while (num < 3);

    /* Using inline function and macros */
    printf("5 + 7 = %d\n", add(5, 7));
    printf("Square of 5 = %d\n", SQUARE(5));

    /* Using union */
    printf("Union value as integer: %d\n", val.iVal);
    val.fVal = 3.14f;
    printf("Union value as float: %f\n", val.fVal);

    /* Using function pointer */
    ActionFunc func = getActionFunction();
    func("Message via function pointer");

    /* Using static functions (increments globalCounter) */
    incrementCounter();
    incrementCounter();
    printf("Global counter now: %d\n", globalCounter);

    /* Print global message */
    printMessage(GLOBAL_MSG);

    /* Free dynamically allocated memory */
    free(dynamicString);

    /* Return statement */
    return 0;
}
