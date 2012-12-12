//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_mob_ui;

/**
 * Abstract base class for most widgets that can receive focus.
 */
abstract class FocusWidget extends Widget implements HasEnabled, HasFocus {

  /**
   * Focus helper class Implementation.
   */
  static FocusHelper focusHelper = new FocusHelper.browserDependent();

  /**
   * Creates a new focus widget that wraps the specified browser [element].
   */
  FocusWidget([dart_html.Element element = null]) {
    if (?element) {
      setElement(element);
    }
  }

  //****************************
  // Impementation of HasEnabled
  //****************************
  /**
   * Gets whether this widget is enabled.
   *
   * @return <code>true</code> if the widget is enabled
   */
  bool get enabled => !Dom.getElementPropertyBoolean(element, "disabled");

  /**
   * Sets whether this widget is enabled.
   *
   * @param enabled <code>true</code> to enable the widget, <code>false</code>
   *          to disable it
   */
  void set enabled(bool value) {
    Dom.setElementPropertyBoolean(element, "disabled", !value);
  }

  //***************************
  // Implementation of HasFocus
  //***************************
  /**
   * Gets the widget's position in the tab index.
   *
   * @return the widget's tab index
   */
  int get tabIndex => focusHelper.getTabIndex(element);

  /**
   * Sets the widget's position in the tab index. If more than one widget has
   * the same tab index, each such widget will receive focus in an arbitrary
   * order. Setting the tab index to <code>-1</code> will cause this widget to
   * be removed from the tab order.
   *
   * @param index the widget's tab index
   */
  void set tabIndex(int index) {
    focusHelper.setTabIndex(element, index);
  }

  /**
   * Explicitly focus/unfocus this widget. Only one widget can have focus at a
   * time, and the widget that does will receive all keyboard events.
   *
   * @param focused whether this widget should take focus or release it
   */
  void set focus(bool focused) {
    if (focused) {
      focusHelper.focus(element);
    } else {
      focusHelper.blur(element);
    }
  }

}
