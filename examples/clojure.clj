(ns example.core
  ;; Declare the namespace. Here we import and require libraries
  ;; for demonstration of different features.
  (:require [clojure.string :as str])
  (:import (java.util Date)))

;; A dynamic Var with metadata, demonstrating ^:dynamic and ^{:doc "..."}
(def ^:dynamic ^{:doc "This is a dynamic var example demonstrating metadata."}
  *my-dynamic-var* 
  42)

;; A simple macro that prints the form it was given, then executes it.
(defmacro my-macro
  "A macro that prints the form it is given, then executes it."
  [form]
  `(do
     (println "Inside macro, form is:" '~form)
     ~form))

;; A simple function that prints a greeting using Java interop (java.util.Date).
(defn greet
  "A simple function that prints a greeting."
  [name]
  (println "Hello," name "the date is" (Date.)))

;; A protocol to demonstrate polymorphism.
(defprotocol Greetable
  (greet-protocol [this] "Protocol-based greeting."))

;; A record implementing our protocol.
(defrecord Person [name]
  Greetable
  (greet-protocol [this]
    (greet (.-name this))))

;; A multimethod that dispatches on the class of its argument.
(defmulti greet-multi (fn [entry] (class entry)))

(defmethod greet-multi Person [p]
  (println "Hello," (:name p) "from multimethod!"))

(defmethod greet-multi String [s]
  (println "Hello," s "you're just a string."))

;; A function demonstrating concurrency with atom, future, and promise.
(defn concurrency-example []
  (let [a (atom 0)
        f (future (swap! a inc))
        p (promise)]
    (deliver p "Promised value!")
    @f
    (println "Atom value:" @a)
    (println "Promise value:" @p)))

;; A function demonstrating destructuring in a vector binding.
(defn destructuring-example [[first second & rest :as all]]
  (println "First is:" first 
           "second is:" second 
           "rest is:" rest 
           "all is:" all))

;; Main entry point. 
(defn -main
  "Main entry point for demonstration."
  [& args]
  ;; Use the macro
  (my-macro (println "Macro test."))
  
  ;; Call a normal function
  (greet "Clojure Enthusiast")
  
  ;; Demonstrate Java interop by starting a Thread.
  (.start (Thread. #(println "Java interop thread started!")))
  
  ;; Demonstrate protocol and multimethod usage
  (let [p (Person. "MultiMethod Person")]
    (greet-protocol p)
    (greet-multi p)
    (greet-multi "Alice"))
  
  ;; Demonstrate concurrency
  (concurrency-example)
  
  ;; Demonstrate destructuring
  (destructuring-example [1 2 3 4 5])
  
  ;; Demonstrate "#inst" and "#uuid" literals
  (println "Instant literal example:" #inst "2021-12-25T10:00:00.000-00:00")
  (println "UUID literal example:" #uuid "550e8400-e29b-41d4-a716-446655440000")
  
  ;; Check a Java system property
  (println "Java version is:" (System/getProperty "java.version"))
  
  ;; Sign off.
  (println "Done."))
