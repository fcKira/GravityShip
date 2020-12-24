using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class ShipBoost : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IPointerExitHandler
{
    public Image boostBar;
    public float totalBoost = 3;
    float _currentBoost;
    bool _beingTouched;

    Action _touchType = delegate { };
    Action _onBegan = delegate { };
    Action _onEnd = delegate { };

    void Start()
    {
        //Mouse or Touch input
        if (Application.isEditor)
            _touchType = PCTouch;
        else
            _touchType = MobileTouch;

        _currentBoost = totalBoost;

        boostBar.fillAmount = 1;

        //Add start and end boost from ship into my buttonUp and buttonDown Actions
        ShipModel ship = FindObjectOfType<ShipModel>();

        if (ship)
        {
            _onBegan = ship.StartBoost;
            _onEnd = ship.StopBoost;
        }
    }


    void Update()
    {
        if (_currentBoost <= 0) return; //Only need to update if I have boost

        //_touchType(); //Action that contains Touch or Mouse input

        if (_beingTouched) //If boost is being touched
        {
            DrainBoost();  //Drain boost
        }
    }

    void TouchBegan()
    {
        _onBegan();
        _beingTouched = true;
    }
    
    void TouchEnd()
    {
        _beingTouched = false;
        _onEnd();
    }

    void DrainBoost()
    {
        _currentBoost -= Time.deltaTime;
        boostBar.fillAmount = _currentBoost/totalBoost;
        if (_currentBoost <= 0)
        {
            TouchEnd();
        }
    }

    void MobileTouch()
    {
        if (Input.touchCount == 0) return;

        Touch touch = Input.GetTouch(0);

        if (touch.phase == TouchPhase.Began)
        {
            RaycastHit2D hitInfo = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(touch.position), Vector2.zero);

            if (hitInfo && hitInfo.transform == transform)
            {
                Debug.Log("Began Touch");
                TouchBegan();
            }
        }

        if (_beingTouched)
        {
            if (touch.phase == TouchPhase.Moved)
            {
                RaycastHit2D hitInfo = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(touch.position), Vector2.zero);

                if (!hitInfo || hitInfo.transform != transform)
                {
                    Debug.Log("Lost Touch");
                    TouchEnd();
                }
            }
            else if (touch.phase == TouchPhase.Canceled || touch.phase == TouchPhase.Ended)
            {
                TouchEnd();
                Debug.Log("End Touch");
            }
        }
    }

    void PCTouch()
    {
        if (Input.GetMouseButtonDown(0))
        {
            RaycastHit2D hitInfo = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);

            if (hitInfo && hitInfo.transform == transform)
            {
                Debug.Log("Began Touch");
                TouchBegan();
            }
        }

        if (_beingTouched)
        {
            if (Input.GetMouseButton(0))
            {
                RaycastHit2D hitInfo = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero);

                if (!hitInfo || hitInfo.transform != transform)
                {
                    Debug.Log("Lost Touch");
                    TouchEnd();
                }
            }
            else if (Input.GetMouseButtonUp(0))
            {
                TouchEnd();
                Debug.Log("End Touch");
            }
        }

    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (_currentBoost > 0)
        {
            //if (Input.GetMouseButton(0))
            //    Debug.Log("VAMAAA");
            TouchBegan();
        }
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        if (_beingTouched)
            TouchEnd();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if (_beingTouched)
            TouchEnd();
    }
}
