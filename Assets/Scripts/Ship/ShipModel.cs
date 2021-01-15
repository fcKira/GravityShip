using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using System;

public class ShipModel : Attractor, IGravitySensitive
{
    public float maxSpeed;
    public float baseSpeed;
    public float boostSpeed;
    public float rotationAngles;
    public float linearDragOnBoost;

    ShipController _controller;

    float _totalSpeed;

    Rigidbody2D _rgbd;

    bool _gettingBoost;

    float _boundWidth, _boundHeight;

    Vector3 _velocityBeforePause = new Vector3();

    Camera _mainCamera;

    public event Action<bool> _onBoost = delegate { };
    public event Action _onDeath = delegate { };

    void Awake()
    {
        _controller = new ShipController(this, GetComponentInChildren<ShipView>());

        _rgbd = GetComponent<Rigidbody2D>();

        _totalSpeed = baseSpeed;

        _rgbd.velocity = transform.up * _totalSpeed;

        _mainCamera = Camera.main;
    }

    private void OnEnable()
    {
        if (_velocityBeforePause != Vector3.zero)
            _rgbd.velocity = _velocityBeforePause;
    }



    protected override void FixedUpdate()
    {
        base.FixedUpdate();

        _controller.ControllerFixedUpdate();

        ClampVelocity();
    }

    private void OnDisable()
    {
        _velocityBeforePause = _rgbd.velocity;
        _rgbd.velocity = Vector3.zero;
    }

    void ClampVelocity()
    {
        var vel = _rgbd.velocity;

        if (!_gettingBoost && _rgbd.drag != 0)
        {
            if (vel.magnitude <= maxSpeed)
            {
                _rgbd.drag = 0;
            }
        }
        else if (_rgbd.drag == 0)
        {
            if (vel.magnitude > maxSpeed)
            {
                _rgbd.velocity = Vector3.ClampMagnitude(vel, maxSpeed);
            }
        }
    }

    public void Movement()
    {
        if (_gettingBoost)
            _rgbd.AddForce(transform.up * boostSpeed);
    }

    public void RotateShip(Vector3 tapPossition)
    {
        if (IsPointerOverUIObject()) return;

        Vector2 realPos = _mainCamera.ScreenToWorldPoint(tapPossition);

        Vector2 dir = ((Vector2)transform.position - realPos).normalized;

        float dotRes = Vector2.Dot(transform.right, dir);

        if (dotRes < 0)
        {
            _rgbd.AddForce(transform.right * (rotationAngles * _rgbd.velocity.magnitude));
        }
        else
        {
            _rgbd.AddForce(transform.right * -(rotationAngles * _rgbd.velocity.magnitude));
        }

        transform.up = _rgbd.velocity.normalized;
    }


    public void StartBoost()
    {
        _onBoost(_gettingBoost = true);
        _rgbd.drag = linearDragOnBoost;
    }

    public void StopBoost()
    {
        _onBoost(_gettingBoost = false);
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);

        transform.up = _rgbd.velocity.normalized;
    }

    void Death()
    {
        _onDeath();
        EventsManager.TriggerEvent(Constants.EVENT_PlayerDeath);
        Destroy(gameObject);
    }

    protected override void Attract()
    {
        Collider2D[] pickables = Physics2D.OverlapCircleAll(transform.position, attractRadius, FlyweightPointer.Asteroid.layerMaskForShip);

        foreach (var obj in pickables)
        {
            obj.GetComponent<IGravitySensitive>().GetExtraForce(attractForce, transform.position);
        }
    }

    private bool IsPointerOverUIObject()
    {
        PointerEventData eventDataCurrentPosition = new PointerEventData(EventSystem.current);
        eventDataCurrentPosition.position = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(eventDataCurrentPosition, results);
        return results.Count > 0;
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        var pickableObj = collision.GetComponent<Pickable>();

        if (pickableObj)
            pickableObj.PickedUp();
        else if (collision.GetComponent<AttractorObj>() || collision.gameObject.layer == 10)
            Death();

    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, attractRadius);
    }

}
