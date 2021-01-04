using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ShipModel : Attractor, IGravitySensitive
{
    public float baseSpeed;
    public float boostSpeed;
    public float rotationAngles;

    ShipController _controller;

    float _totalSpeed;

    Rigidbody2D _rgbd;

    bool _gettingBoost;

    float _boundWidth, _boundHeight;

    Vector3 _velocityBeforePause = new Vector3();

    Camera _mainCamera;

    void Awake()
    {
        _controller = new ShipController(this, GetComponent<ShipView>());

        _rgbd = GetComponent<Rigidbody2D>();

        _totalSpeed = baseSpeed;

        _rgbd.velocity = transform.right * _totalSpeed;

        _mainCamera = Camera.main;

        _boundHeight = _mainCamera.orthographicSize;
        _boundWidth = _boundHeight * Screen.width / Screen.height;

    }

    private void OnEnable()
    {
        if (_velocityBeforePause != Vector3.zero)
            _rgbd.velocity = _velocityBeforePause;
    }

    private void Start()
    {
        EventsManager.TriggerEvent(Constants.EVENT_SetPlayer, this);
    }

    private void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);
            RotateShip(touch.position);
        }

        if (Input.GetMouseButton(0))
        {
            Vector3 mousePosition = Input.mousePosition;

            RotateShip(Input.mousePosition);

        }
    }

    protected override void FixedUpdate()
    {
        base.FixedUpdate();

        _controller.ControllerFixedUpdate();
        
    }

    void LateUpdate()
    {
        if (transform.position.x > _boundWidth || transform.position.x < -_boundWidth || transform.position.y < -_boundHeight || transform.position.y > _boundHeight)
        {
            UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
        }
    }

    private void OnDisable()
    {
        _velocityBeforePause = _rgbd.velocity;
        _rgbd.velocity = Vector3.zero;
    }

    public void Movement()
    {
        //if (_rgbd.velocity.magnitude < _totalSpeed)
        //{
        //    _rgbd.AddForce(transform.right * _totalSpeed);
        //}

        if (_gettingBoost)
            _rgbd.AddForce(transform.right * boostSpeed);

        transform.right = _rgbd.velocity.normalized;
    }

    public void RotateShip(Vector3 tapPossition)
    {
        if (IsPointerOverUIObject()) return;

        Vector2 realPos = _mainCamera.ScreenToWorldPoint(tapPossition);

        Vector2 dir = ((Vector2)transform.position - realPos).normalized;

        float dotRes = Vector2.Dot(transform.up, dir);

        if (dotRes < 0)
        {
            _rgbd.AddForce(transform.up * rotationAngles);
        }
        else
        {
            _rgbd.AddForce(transform.up * -rotationAngles);
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

    public void StartBoost()
    {
        //_totalSpeed += boostSpeed;
        _gettingBoost = true;
    }

    public void StopBoost()
    {
        //_totalSpeed -= boostSpeed;
        _gettingBoost = false;
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);
    }

    protected override void Attract()
    {
        Collider2D[] pickables = Physics2D.OverlapCircleAll(transform.position, attractRadius, FlyweightPointer.Asteroid.layerMaskForShip);

        foreach (var obj in pickables)
        {
            obj.GetComponent<IGravitySensitive>().GetExtraForce(attractForce, transform.position);
        }
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        var pickableObj = collision.GetComponent<Pickable>();
        
        if (pickableObj)
            pickableObj.PickedUp();
        else if (collision.GetComponent<AttractorObj>())
            UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);

    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawWireSphere(transform.position, attractRadius);
    }

}
