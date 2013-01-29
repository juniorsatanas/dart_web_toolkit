//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

part of dart_web_toolkit_ui;

/**
 * A widget that wraps an IFRAME element, which can contain an arbitrary web
 * site.
 *
 * <p>Note that if you are using {@link com.google.dwt.user.client.History}, any
 * browser history items generated by the Frame will interleave with your
 * application's history.</p>
 *
 * <h3>CSS Style Rules</h3>
 * <ul class='css'>
 * <li>.dwt-Frame { }</li>
 * </ul>
 *
 * <p>
 * <h3>Example</h3> {@example com.google.dwt.examples.FrameExample}
 * </p>
 */
class Frame extends Widget implements HasLoadHandlers {

  static final String DEFAULT_STYLENAME = "dwt-Frame";

  /**
   * Creates a Frame widget that wraps an existing &lt;frame&gt; element.
   *
   * This element must already be attached to the document. If the element is
   * removed from the document, you must call
   * {@link RootPanel#detachNow(Widget)}.
   *
   * @param element the element to be wrapped
   */
  factory Frame.wrap(dart_html.Element element) {
    // Assert that the element is attached.
    assert (dart_html.document.body.children.contains(element));

    Frame frame = new Frame.fromElement(element);

    // Mark it attached and remember it for cleanup.
    frame.onAttach();
    RootPanel.detachOnWindowClose(frame);

    return frame;
  }

  /**
   * Creates an empty frame or a frame that displays the resource at the
   * specified URL.
   *
   * @param url the URL of the resource to be displayed
   */
  Frame([String url = null]) {
    setElement(new dart_html.IFrameElement());
    clearAndSetStyleName(DEFAULT_STYLENAME);
    if (url != null) {
      setUrl(url);
    }
  }
  /**
   * This constructor may be used by subclasses to explicitly use an existing
   * element. This element must be an &lt;iframe&gt; element.
   *
   * @param element the element to be used
   */
  Frame.fromElement(dart_html.Element element) {
    setElement(element);
  }

  /**
   * Adds a {@link LoadEvent} load handler which will be called when the frame
   * loads.
   *
   * @param handler the load handler
   * @return {@link HandlerRegistration} that can be used to remove this handler
   */
  HandlerRegistration addLoadHandler(LoadHandler handler) {
    return addDomHandler(handler, LoadEvent.TYPE);
  }

  /**
   * Gets the URL of the frame's resource.
   *
   * @return the frame's URL
   */
  String getUrl() {
    return getFrameElement().src;
  }

  /**
   * Sets the URL of the resource to be displayed within the frame.
   *
   * @param url the frame's new URL
   */
  void setUrl(String url) {
    getFrameElement().src = url;
  }

//  /**
//   * Sets the URL of the resource to be displayed within the frame.
//   *
//   * @param url the frame's new URL
//   */
//  void setUrl(SafeUri url) {
//    setUrl(url.asString());
//  }

  dart_html.IFrameElement getFrameElement() {
    return getElement() as dart_html.IFrameElement;
  }
}