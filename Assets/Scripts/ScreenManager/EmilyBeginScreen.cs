using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using System;

public class EmilyBeginScreen : TransitionBaseScreen, IScreen
{
    public TMP_Text myTextBox;
    public GameObject myBubbleText;

    [Range(0.01f, 0.1f)]
    public float timeBetweenLetters = 0.1f; 

    string _myText;

    bool _active;

    Action _updateState;

    protected override void Awake()
    {
        GetComponent<Canvas>().worldCamera = Camera.main;

        _myRectTransform = transform.GetChild(0).GetComponent<RectTransform>();

        _myText = myTextBox.text;
        myTextBox.text = "";

        myBubbleText.SetActive(false);

        _onEndShowTransition += ActiveTextBubble;
    }

    private void Update()
    {
        _updateState?.Invoke();
    }

    void ActiveTextBubble()
    {
        myBubbleText.SetActive(true);

        StartCoroutine(FillTextByTime());
    }

    IEnumerator FillTextByTime()
    {
        for (int i = 0; i < _myText.Length; i++)
        {
            myTextBox.text += _myText[i];

            yield return new WaitForSeconds(timeBetweenLetters);
        }

        _updateState += CheckToDeleteScreen;
    }

    void CheckToDeleteScreen()
    {
        if (Input.touchCount > 0 || Input.GetMouseButton(0))
        {
            _updateState -= CheckToDeleteScreen;
            myBubbleText.SetActive(false);
            _onEndOutTransition += ScreenManager.instance.Pop;
            StartCoroutine(OutMenu());
        }
    }

    public void Activate()
    {
        _active = true;
    }

    public void Deactivate()
    {
        _active = false;
    }

    public void Free()
    {
        Destroy(gameObject);
    }
}
