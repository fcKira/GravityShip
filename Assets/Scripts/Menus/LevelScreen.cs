using System.Collections;
using UnityEngine;

[RequireComponent(typeof(RectTransform))]
public class LevelScreen : MonoBehaviour
{
    RectTransform _myRectTransform;
    float _screenHeight, _screenWidth;

    public Vector2 showDirection;
    [Range(0.1f, 2f)]
    public float showSpeedMultiplier = 0.1f;

    void Awake()
    {
        _myRectTransform = GetComponent<RectTransform>();
        _screenHeight = Screen.currentResolution.width;
        _screenWidth = Screen.currentResolution.height;
    }

    void OnEnable()
    {
        _myRectTransform.anchoredPosition += new Vector2(_screenWidth * showDirection.x, _screenHeight * showDirection.y);

        StartCoroutine(ShowMenu());
    }

    void OnDisable()
    {
        StopAllCoroutines();
    }

    IEnumerator ShowMenu()
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
    }
}
