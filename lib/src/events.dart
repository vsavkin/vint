typedef Listener(event);

/**
* Utility class to manage event listeners.
*/
class Listeners {
  final List listeners = [];

  Listeners add(Listener listener){
    listeners.add(listener);
    return this;
  }

  void dispatch(event) {
    listeners.forEach((fn) {fn(event);});
  }
}

/**
* Utility class to manage multiple event types.
*/
class EventMap {
  final _listeners = new Map();

  Listeners listeners(String eventType){
    _listeners.putIfAbsent(eventType, () => new Listeners());
    return _listeners[eventType];
  }
}

/**
* Event map for the ModelList class.
*/
class CollectionEvents extends EventMap {
  Listeners get load => listeners("load");
  Listeners get insert => listeners("insert");
  Listeners get remove => listeners("remove");
  Listeners get update => listeners("update");
}

/**
* An event that is raised after a collection's initial load.
*/
class CollectionLoadEvent {
  final collection;

  CollectionLoadEvent(this.collection);
}

/**
* Event raised after a new record was inserted into a collection.
*/
class CollectionInsertEvent {
  final collection, model;

  CollectionInsertEvent(this.collection, this.model);
}

/**
* Event raised after a record was removed from its collection.
*/
class CollectionRemoveEvent {
  final collection, model;

  CollectionRemoveEvent(this.collection, this.model);
}

/**
* Event map for the Model class.
*/
class ModelEvents extends EventMap {
  Listeners get change => listeners("change");
}

/**
* Event raised after a model's attribute was changed.
*/
class ChangeEvent {
  final String attrName;
  final model;
  final oldValue;
  final newValue;

  ChangeEvent(this.model, this.attrName, this.oldValue, this.newValue);
}