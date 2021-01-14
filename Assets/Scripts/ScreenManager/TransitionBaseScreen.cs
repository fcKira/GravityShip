using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

[RequireComponent(typeof(RectTransform))]
public class TransitionBaseScreen : MonoBehaviour
{
    protected RectTransform _myRectTransform;

    public Vector2 showDirection;
    [Range(0.1f, 2f)]
    public float showSpeedMultiplier = 0.1f;

    protected Action _onEndShowTransition;
    protected Action _onStartOutTransition;
    protected Action _onEndOutTransition;

    // Start is called before the first frame update
    protected virtual void Awake()
    {
        _myRectTransform = GetComponent<RectTransform>();
    }

    protected virtual void OnEnable()
    {
        _myRectTransform.anchoredPosition += new Vector2(Screen.currentResolution.height * showDirection.x, Screen.currentResolution.width * showDirection.y);

        StartCoroutine(ShowMenu());
    }

    protected virtual void OnDisable()
    {
        StopAllCoroutines();
    }

    protected virtual IEnumerator ShowMenu()
    {
        Vector2 oldPos = _myRectTransform.anchoredPosition;
        Vector2 newPos = Vector2.zero;
        float ticks = 0;

        while (ticks < 1)
        {
            ticks += Time.deltaTime * showSpeedMultiplier;
            _myRectTransform.anchoredPosition = Vector2.Lerp(oldPos, newPos, ticks);
            yield return null;
        }

        _myRectTransform.anchoredPosition = newPos;

        _onEndShowTransition?.Invoke();
    }

    protected virtual IEnumerator OutMenu()
    {
        _onStartOutTransition?.Invoke();

        Vector2 oldPos = _myRectTransform.anchoredPosition;
        Vector2 newPos = new Vector2(Screen.currentResolution.height * showDirection.x, Screen.currentResolution.width * showDirection.y);
        float ticks = 0;

        while (ticks < 1)
        {
            ticks += Time.deltaTime * showSpeedMultiplier;
            _myRectTransform.anchoredPosition = Vector2.Lerp(oldPos, newPos, ticks);
            yield return null;
        }

        _myRectTransform.anchoredPosition = newPos;

        _onEndOutTransition?.Invoke();
    }
}
